Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA387430C7
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jun 2023 00:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjF2Wzl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Jun 2023 18:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjF2Wzk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Jun 2023 18:55:40 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103052728;
        Thu, 29 Jun 2023 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1688079337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wEIr5z1x+jp+LXHn1pTpDTIoXopj5PtkFmRIdw0m8qE=;
        b=ysVsAx3vbFQvscKRO+Zy1dJAntSPxmPETtks0F3r3NBinLvthxNnTEfr8wiJsVmapOofv0
        7gPe04k+3Fz7x8aOKYs0serspuPg2Angqzae0b93I0rcIf2Yt9ufQOkDYJzT3tTrw5PrI4
        PC8WmDG2ZZUrlhphmUj8itutJ6hZqYw=
Date:   Fri, 30 Jun 2023 00:55:29 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/8] pwm: jz4740: Put per-channel clk into driver data
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mips@vger.kernel.org
Message-Id: <HCE1XR.D74206DFB5G5@crapouillou.net>
In-Reply-To: <20230629140745.fknzjerunbl2wr3k@pengutronix.de>
References: <notmuch-sha1-d2bb15a9dcb5470a6eebca0b1a01c57918a22695>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le jeu. 29 juin 2023 =E0 16:07:45 +0200, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello Paul,
>=20
> first of all, your mail is strange. I think the problem is that it
> doesn't contain a Message-Id. The result is that I got it twice and in
> return vger.kernel.org seems to have refused to take it. At least it's
> neither in lore.kernel.org nor in
> https://patchwork.ozlabs.org/project/linux-pwm/patch/20230629094839.75709=
2-4-u.kleine-koenig@pengutronix.de/
> .

Sorry about that, I'm at the Embedded Linux conference in Prague=20
without my computer, so I just answered from my Android phone. I didn't=20
know it would cause problems, I guess I'll refrain from doing that from=20
now on.

Cheers,
-Paul

>=20
> On Thu, Jun 29, 2023 at 01:12:25PM +0200, Paul Cercueil wrote:
>>  Le 29 juin 2023 11:48, Uwe Kleine-K=F6nig=20
>> <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  >
>>  > Stop using chip_data which is about to go away. Instead track the
>>  > per-channel clk in struct jz4740_pwm_chip.
>>  >
>>  > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>>  > ---
>>  > drivers/pwm/pwm-jz4740.c | 11 +++++++----
>>  > 1 file changed, 7 insertions(+), 4 deletions(-)
>>  >
>>  > diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
>>  > index 3b7067f6cd0d..e0a57d71a60c 100644
>>  > --- a/drivers/pwm/pwm-jz4740.c
>>  > +++ b/drivers/pwm/pwm-jz4740.c
>>  > @@ -27,6 +27,7 @@ struct soc_info {
>>  > struct jz4740_pwm_chip {
>>  > struct pwm_chip chip;
>>  > struct regmap *map;
>>  > + struct clk *clk[];
>>  > };
>>  >
>>  > static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip=20
>> *chip)
>>  > @@ -70,14 +71,15 @@ static int jz4740_pwm_request(struct pwm_chip=20
>> *chip, struct pwm_device *pwm)
>>  > return err;
>>  > }
>>  >
>>  > - pwm_set_chip_data(pwm, clk);
>>  > + jz->clk[pwm->hwpwm] =3D clk;
>>  >
>>  > return 0;
>>  > }
>>  >
>>  > static void jz4740_pwm_free(struct pwm_chip *chip, struct=20
>> pwm_device *pwm)
>>  > {
>>  > - struct clk *clk =3D pwm_get_chip_data(pwm);
>>  > + struct jz4740_pwm_chip *jz =3D to_jz4740(chip);
>>  > + struct clk *clk =3D jz->clk[pwm->hwpwm];
>>  >
>>  > clk_disable_unprepare(clk);
>>  > clk_put(clk);
>>  > @@ -123,7 +125,7 @@ static int jz4740_pwm_apply(struct pwm_chip=20
>> *chip, struct pwm_device *pwm,
>>  > {
>>  > struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);
>>  > unsigned long long tmp =3D 0xffffull * NSEC_PER_SEC;
>>  > - struct clk *clk =3D pwm_get_chip_data(pwm);
>>  > + struct clk *clk =3D jz4740->clk[pwm->hwpwm];
>>  > unsigned long period, duty;
>>  > long rate;
>>  > int err;
>>  > @@ -229,7 +231,8 @@ static int jz4740_pwm_probe(struct=20
>> platform_device *pdev)
>>  > if (!info)
>>  > return -EINVAL;
>>  >
>>  > - jz4740 =3D devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
>>  > + jz4740 =3D devm_kzalloc(dev, sizeof(*jz4740) + info->num_pwms *=20
>> sizeof(jz4740->clk[0]),
>>  > +       GFP_KERNEL);
>>=20
>>  LGTM, but please use struct_size() from <linux/overflow.h>.
>=20
> Ah, I thought there is such a macro, but I didn't find it neither by
> grepping nor by asking in #kernelnewbies. Thanks, will respin the=20
> series
> in a few days.
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> https://www.pengutronix.de/ |


