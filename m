Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA7296972
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Oct 2020 07:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371598AbgJWFlq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Oct 2020 01:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S371576AbgJWFlq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 23 Oct 2020 01:41:46 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02DDD20BED;
        Fri, 23 Oct 2020 05:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603431705;
        bh=Oe/vLGsyhwfOt3LYK05Ez026hYbO1+/n1v+vRTwBy2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z/cbW75qPIw1uwojDU5DqSmvmGEQMYvz1ChR1phMrTkQPqGdMUiF1dUTIGwrP1V94
         o5EO0Cpi1Tc00pMmPSkuJtvjprUMhxitTlAJnY0YyYmXGjfYiV4zbGtMqfRjl/b9Ii
         +xt2lfCMKCqmnltSTi4ueEyl9xKcvVdinZc3MA6M=
Date:   Fri, 23 Oct 2020 07:41:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Kamil Debski <kamil@wypas.org>
Subject: Re: [PATCH 1/4] MAINTAINERS: move Kamil Debski to credits
Message-ID: <20201023074137.1034a8df@coco.lan>
In-Reply-To: <20201022200925.GA2525@kozik-lap>
References: <20201016151528.7553-1-krzk@kernel.org>
        <20201022191314.plesyizmczgdmodr@pengutronix.de>
        <20201022200925.GA2525@kozik-lap>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Em Thu, 22 Oct 2020 22:09:25 +0200
Krzysztof Kozlowski <krzk@kernel.org> escreveu:

> On Thu, Oct 22, 2020 at 09:13:14PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > this series doesn't seem to be applied and looking at the list of people
> > this mail was sent "To:" it's not obvious who is expected to take it. I
> > assume it is not for us linux-pwm guys and will tag it as
> > "not-applicable" in our patchwork. =20
>=20
> Hi Uwe,
>=20
> All of the patches, including the one here, touch actually multiple
> subsystems, so if this is OK with you, I could take them through
> Samsung SoC.

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>=20
> Best regards,
> Krzysztof
>=20



Thanks,
Mauro
