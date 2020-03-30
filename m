Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD0198169
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgC3QlU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 12:41:20 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53590 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC3QlU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 12:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1585586476; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQAjpeP0ttna+M7acg2Qd2oZ1ja9i8Cn7x068Tgta1w=;
        b=G/ImTS8808q+pnxeBUdAY668zG/YSSC3Fbif0jFMowpr/KK3vToUvBogUe8tLsGR3OfNAd
        7Vg7p2w5OQT44xLd0onL4f7NRr0Bs3jaqK6kqduYRCJ4kBsjZv2tqVL68JqxHMHfGUE713
        GJ2wkAfqyIaxDFxztQQ5apUF0k1jQ7I=
Date:   Mon, 30 Mar 2020 18:41:04 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 3/4] pwm: jz4740: Obtain regmap from parent node
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <GCM08Q.D2GF67F5O2R03@crapouillou.net>
In-Reply-To: <20200330143716.GI2431644@ulmo>
References: <20200323142421.42817-1-paul@crapouillou.net>
        <20200323142421.42817-3-paul@crapouillou.net>
        <20200330143716.GI2431644@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

Le lun. 30 mars 2020 =E0 16:37, Thierry Reding=20
<thierry.reding@gmail.com> a =E9crit :
> On Mon, Mar 23, 2020 at 03:24:20PM +0100, Paul Cercueil wrote:
> [...]
>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> [...]
>>  @@ -196,12 +208,19 @@ static const struct pwm_ops jz4740_pwm_ops =3D {
>>   static int jz4740_pwm_probe(struct platform_device *pdev)
>>   {
>>   	struct jz4740_pwm_chip *jz4740;
>>  +	struct device *dev =3D &pdev->dev;
>>=20
>>  -	jz4740 =3D devm_kzalloc(&pdev->dev, sizeof(*jz4740), GFP_KERNEL);
>>  +	jz4740 =3D devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
>>   	if (!jz4740)
>>   		return -ENOMEM;
>>=20
>>  -	jz4740->chip.dev =3D &pdev->dev;
>>  +	jz4740->map =3D device_node_to_regmap(dev->parent->of_node);
>>  +	if (!jz4740->map) {
>=20
> This seems wrong. According to the code, device_node_to_regmap()=20
> returns
> an ERR_PTR()-encoded error code on failure, so I think this should be:
>=20
> 	if (IS_ERR(jz4740->map)) {
> 		...
> 		return PTR_ERR(jz4740->map);
> 	}
>=20
> No need to resend for that, I can take care of that when applying. Let
> me know if that doesn't work.

Yes, that works for me. Good catch.

Thanks,
-Paul

>=20
> Thierry


