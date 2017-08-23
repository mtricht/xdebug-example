<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController
{
    /**
     * @Route("/")
     */
    public function indexAction()
    {
        $math = new Math();
        $math->random();
        $math->add(5);
        $math->subtract(15);

        return new Response(
            '<html><body>Lucky number: '.$math->getResult().'</body></html>'
        );
    }
}

class Math {

    private $current = 0;

    public function random() {
        $this->current = mt_rand(0, 100);
    }

    public function add($x) {
        $this->current += $x;
    }

    public function subtract($x) {
        $this->current -= $x;
    }

    public function getResult() {
        return $this->current;
    }
}