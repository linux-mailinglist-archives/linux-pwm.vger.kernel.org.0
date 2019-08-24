Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14EF9BE38
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 16:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfHXOSI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 10:18:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:40429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbfHXOSH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 24 Aug 2019 10:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566656278;
        bh=iKSbxvc/xWDvAHlk1241pDSgA85KQKsTFVK6AGOJ5hQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KbvI6VuDg+bpbF5Slss0G1kE8cerQCRJQ6cobNw9twbSG/DHYJ61RbFEbOTN6sUNz
         ETMf1mJsF3BkyIC7KgBeF5LZxdELI7R2/usBYayBgroibKdu4dGszQagnqhZIIOkXq
         AcGzsZEHcL60ztAR5QBjV2VoqKDGzL/jEMukdkFA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.106]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs4Z-1iWEz900qP-00mtSl; Sat, 24
 Aug 2019 16:17:58 +0200
Subject: Re: [PATCH 0/3] pwm: bcm2835: Minor fixes
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
 <20190824092553.j4rjpzaz4m6yaa5t@pengutronix.de>
 <22f8e65b-2d65-84e7-de50-ba6538a84292@gmx.net>
 <20190824105614.wpkvqqxjey6umhrs@pengutronix.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <c6d26f19-a9ef-1c64-b8e2-94b7a4f93487@gmx.net>
Date:   Sat, 24 Aug 2019 16:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824105614.wpkvqqxjey6umhrs@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:K95rpfokptfPiW2E9MnFydUdlwDj3gFsL8ZjduGx89wWcO1DC9x
 2T/i8IHGXrvPBt+dkb87F3GcHn4XBcB61ZZ6AOc5UQHvs3buzxjt11p7V1oMXRj66E2oMgX
 bJh6gHTkIQPLrr//u4J+tCxWvlekRYMKKiz3GXnjFHplLS8sLydqJmNWhHx8g0PY0VEFLhF
 MyKWqNdGMgOEXuvi1vyew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nP/VAcFaR/o=:7wlAEzKHd63qhOeMBeGYtq
 +e7VfJIAa72RkZk7ASYdfUNYHv5LIz40VsLqim4QYZA0wAiGPOyMRUM+Mz0Ol5lDGEU1SyxYi
 ++yUM39Vmna+OxG+84rKNNa1zUBMKJsnbo/Cb3RIZ9qc0hSkVE1BYaPynM1R5EZHQVYPd5Vtn
 9C47aT4toFXcbZ7ShkEYWfMEIfRTOwDac9ZkVlxIDLYsCbMK8+bIkjCFpXduCNb8uyJvc3vMQ
 TKtBL5wcmULSw08Ew368Gd8Vrr21kbUvGibpssRPegTy4bWnLGTjtXUYuP59unLR1oL/nvyI9
 rKzTlx2BJl7DlLjPpHXS02UO2FA9JovrjEeqpWywv8Uom9WQm6raAxUSuffH42w/EFV7mtZiw
 oKYY01Rbk82w67NmMbCqJA7wxAeLmKssIuj8GCDW988fyNVoqf04PINMVhBxReRml8l+xSz4P
 J7LI23aupM4NSR1WqPXjrs5uVnpSQj/GoZbhrhOe2VMZ0i/dL9kK0iwll9h6QlnbtQCqoNHuI
 083nc9eRQm5GhOC9pt6glQRzbwncXEba8MkpSSM9rgUp7agJZ6pBLXSWec3OlD/1OzwFL1dN4
 NhM1wjzRGG0Y+wo5/479HuJDdW7gvoXh672ftJ3PM1b6ePv58pQq/JFHyNIPHiQbE5RvlS19k
 VwdP1vKtfDFImr+ct7xwOQjiUFcywHNfEULLUAIaqD2XN08dX1zDqiVjdMmzj2BW83gdv/6oi
 efJ7G4431vE1H0CLIrmin/qQclAR2p3QqYEjd+FcEhgytw7s3IwFCQEKV7oEuyNO5DmykbgEH
 uXcwUka3CxllAbshQs+9WYzI7hFt9XD71OLhW3Yg79MLxIOcVHdc5V41kxZgRgUWUfyiYUHK8
 82geNQJPRNRY273sjydbd2K7iZfB/b7abVfrJ3Ji//S6HAGcTVPg7xsMX+WVqZ4FR13OwLGFk
 9SooqSzi5C9b3PzCthyqyprYFhOL41pLr2F/VGiG99fHZsOEaZ5ErpduOYPFUGUqdAEM2JDUF
 1fsbsOYk7QQ3uMERTF+ERWsN72Sq7IG/IlrVFJJJZva/x/zIKR3TNkOSjjxkdRGhtiinz0NBm
 Bk5exXETNi0Hp3v9c7dlAfMHlkIhRQaynnfLKv/v8iJStSWbq7iSnVBubE9q753h9o+8NrQCX
 RVLng=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Am 24.08.19 um 12:56 schrieb Uwe Kleine-K=C3=B6nig:
> Hello Stefan,
>
> On Sat, Aug 24, 2019 at 12:05:00PM +0200, Stefan Wahren wrote:
>> Am 24.08.19 um 11:25 schrieb Uwe Kleine-K=C3=B6nig:
>>> Hello Stefan,
>>>
>>> On Sat, Aug 24, 2019 at 09:07:22AM +0200, Stefan Wahren wrote:
>>>> This small patch series contains minor fixes for clock handling and t=
he
>>>> period range check.
>>> I'd like to understand the various different usecases of PWMs. The
>>> in-kernel consumers are kind of obvious, but sysfs users are not. It
>>> seems you are one of the latter.
>>>
>>> Would you mind sharing what you control using the PWM?
>> not really a PWM user with BCM2835. It's more the motivation as a
>> platform maintainer to keep the drivers in shape. At work we are using
>> sysfs interface for user applications to control ventilation (via hwmon
>> interface) and EV charging (IEC 61851) with a different SoC.
> I don't understand how you use the sysfs interface and still interact
> with the hwmon interface. Other than that, thanks for sharing.
I meant the hwmon sysfs interface. Sure using with pwm sysfs in parallel
isn't possible.
>
>
>>> Assuming you have some interest in this driver: It still uses the lega=
cy
>>> stuff implementing .config, .enable, .disable, .set_polarity. Are you
>>> willing to test (or even implement) a switch to .apply instead?
>> Yes, definitely. This is one of my never ending TODO list [1]. But i
>> would be suprised that you wont have access to a Raspberry Pi.
> So be surprised :-)
>
>>> Just from a quick lock into the driver I wonder a few things, maybe yo=
u
>>> can shed some light here. If there is publicly available documenation
>>> for this piece of hardware, feel free to point this out, then I might =
be
>>> able to work out some of the answers myself.
>> Fortunately yes [2]
> Care to add a link to this document in the driver for others to easily
> find it?
I don't think it's necessary. This document is easy to find via "bcm2835
datasheet".
>
> Best regards
> Uwe
>
