Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E38A2D72D7
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 10:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405636AbgLKJaj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 04:30:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:53533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405629AbgLKJaV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 11 Dec 2020 04:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607678915;
        bh=iPll/PusoVBRg6UIQr4NA0ufRAkfzahjvv228y/JzPo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=J8vN7g9w1jbDQsgAhZcGMj37NQG4Fzwg9YQeqYYxM9O6Tj6b1XWjS08iLjvzhEPN7
         55y41/V+me6JIFsxzaa6GvqQwlZAllGU07F2/PrU+nCGI6YrLxg8vov8BsPih8QXi5
         JqZjzoF70fejPk09wjOq0S199kZg8glyK7La1ZFU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [87.130.101.138] ([87.130.101.138]) by web-mail.gmx.net
 (3c-app-gmx-bs43.server.lan [172.19.170.95]) (via HTTP); Fri, 11 Dec 2020
 10:28:35 +0100
MIME-Version: 1.0
Message-ID: <trinity-8db15ca3-e42e-497d-8718-b4928fa76a3c-1607678915350@3c-app-gmx-bs43>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sean@mess.org, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH v3] pwm: bcm2835: Support apply function for atomic
 configuration
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Dec 2020 10:28:35 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20201210114330.6pgtome3aq3hj55t@pengutronix.de>
References: <1607464905-16630-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201210114330.6pgtome3aq3hj55t@pengutronix.de>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:5XfrySyGoCpxU/8ypprwMqLwvM77fUCJpG/oQkqelrhyMl5Tc40C4AQQY5qj8ACssdbqs
 Pr0e3SYAxREOrpJ53G0IZtR9rY+6wgn+OQj88Eb6HXkwdHPBJ1bAUZCdF/Xel1lI47ZZyjHulKdC
 klX5LIWE4gOtn7fgjlyeywT+u7QklNYSjgePZ7omLTWKhw5wtc2kKZvW2DdrtjOxsTmTQR1vlLOs
 8STz8JK/spAnqkxYAcB45YYyqPB0fUrQ4iac1dhjmljeKyILxtZ4cZbeFdtWQdGXa9IsdC8/xtVM
 YY=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GpVFiJHAphU=:JUAcvSqZ1b+uQqYCWk6dGA
 4SegBPvjq3Rs3SMd/AqMPdPaoeU94YJCnYRYB/75+Qt1zkg3FkGIqFsQEBQuGl/1+fH5pGXbF
 upABcd/kqeVMjw1qQfHa10y04fZzBuKx6l4hhjYv/Lm2w9v/w1QCVUlUQeTEvFinzOn+edpS5
 ve9c9MNL5qrdo7uSmCISoEsV0XylSyOqV1Tw5URJimyBra5X86lsWlcs7DCh7Nr/iVhnk4rhl
 GYvrqRNWaxNC6KkYgN/XwBgb9yORbNdxBChqvT/abJ5nIWvAN5OMHU0gyk1yhqJQ+SI+4sbRn
 zmZYdJi+t67HzxU5VNGLSaE5ID0Pp2tYiHMofqI/XdKPhrp4AHviZ7rV+XvpDK+r0Ciij6QSI
 BsFYIkIWteiPHxkBvnXKmuu0vdc3fSqJ6FTesz/Waze20CRhVdqDY+bL6ekIBWZXVABLMcpw4
 wMuvcN7p+QJCNAhGmQFPGhcyPn+SgOJcjbeFRskN5Lc5CTD6BD9CQb/tZGDVq8hyqcJMCZ873
 uCrEhd0koqgaNh+z9qE+odLVqyxaRyVgH068Y7kdxKFVjI3QlMGIPsnZMYygl5OOhxDKyp/oF
 7IPcI15hHxw6c=
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> Gesendet: Donnerstag, 10=2E Dezember 2020 um 12:43 Uhr
> Von: "Uwe Kleine-K=C3=B6nig" <u=2Ekleine-koenig@pengutronix=2Ede>
> An: "Lino Sanfilippo" <LinoSanfilippo@gmx=2Ede>
> Cc: thierry=2Ereding@gmail=2Ecom, lee=2Ejones@linaro=2Eorg, nsaenzjulien=
ne@suse=2Ede, f=2Efainelli@gmail=2Ecom, rjui@broadcom=2Ecom, sean@mess=2Eor=
g, sbranden@broadcom=2Ecom, bcm-kernel-feedback-list@broadcom=2Ecom, linux-=
pwm@vger=2Ekernel=2Eorg, linux-rpi-kernel@lists=2Einfradead=2Eorg, linux-ar=
m-kernel@lists=2Einfradead=2Eorg, linux-kernel@vger=2Ekernel=2Eorg
> Betreff: Re: [PATCH v3] pwm: bcm2835: Support apply function for atomic =
configuration

>=20
> Side note: I'm a bit surprised about the output of
>=20
> 	b4 diff 1607464905-16630-1-git-send-email-LinoSanfilippo@gmx=2Ede
>=20
> This is probably due to the fact that compared to v3 you also rebased=2E
> Still the diff is quite big=2E

You are right, I made a rebase before I created the last patch, sorry for =
the confusion this caused=2E
Anyway, thanks for the review(s)!

Regards,
Lino


