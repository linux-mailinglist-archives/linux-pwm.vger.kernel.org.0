Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132B31F066E
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jun 2020 14:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgFFMKX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 6 Jun 2020 08:10:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43242 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFFMKX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 6 Jun 2020 08:10:23 -0400
X-Greylist: delayed 1382 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jun 2020 08:10:20 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q1hE1By2w6tdlelWUzgDL9pNEpalt4sHuIMqHFjQjp8=; b=k3fx9IKijx/wg1gi89wPskkRj
        qSJnkyjDFkHUduWjPiD4PsWrnb2+RVPaizPta11NotezqIsLn1oxzVSNvnszEdO6FARP/jF+sntaC
        MnUHGVN+Z24JRtKvk6f3h4BeEZnju966pPcxiFNt+ga2Sbf/VPisLqymd8KuYebH1Wqlw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1jhXHh-0004Y4-Ov; Sat, 06 Jun 2020 11:46:45 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3343CD06634; Sat,  6 Jun 2020 12:46:45 +0100 (BST)
Date:   Sat, 6 Jun 2020 12:46:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Message-ID: <20200606114645.GB2055@sirena.org.uk>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
X-Cookie: You do not have mail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> Am 2020-06-05 12:50, schrieb Mark Brown:

> > I have no idea what you are thinking of when you say "simple-regmap" so
> > it is difficult to comment.

> I guess, Lee is suggesting to be able to create a regmap instance via
> device tree (and populate its child nodes?). Like
>   compatible = "syscon", "simple-mfd";
> but for any regmap, not just MMIO.

I don't understand why this would be anything separate to
simple-mfd.

> But, there is more in my driver:
>  (1) there is a version check
>  (2) there is another function for which there is no suitable linux
>      subsystem I'm aware of and thus which I'd like to us sysfs
>      attributes for: This controller supports 16 non-volatile
>      configuration bits. (this is still TBD)

TBH I'd also say that the enumeration of the subdevices for this
device should be in the device rather than the DT, they don't
seem to be things that exist outside of this one device.

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7bgiQACgkQJNaLcl1U
h9CJwAf9GDLvYJzqBwwJ8Wam2ddh4vI4HhG+7om7V0rPbtc+8urivLRpsn4PzyP2
VEDJVR0PhbtQTX11tUL9oNelTz+H+JHuuGMFCWP/DbbHsTKucuhkpelUnW17FukC
sr8O5n3D6en4l8bj6vsfjqysrIAtZWKk+xStpf8bQ9Zu9rczpbIGa2XK6r10w27Y
jcr5C4pQfl7DlyEwdfOw22i+q+dbBuPGPd/zk/7iRp8QzvmHjE9MCr20JO3s0cuO
4wwwbMMyNZAe2HjD1IOyVfJ42Yhd+Yf+IkgSShozuk03IuU1HEWpHTyV36pXBdvs
N4lga9r/upJOfAP2iW7qqtIdU4NzZA==
=M9Xv
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
