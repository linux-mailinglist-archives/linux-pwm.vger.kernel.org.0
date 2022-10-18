Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4219602EFB
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Oct 2022 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiJRO5M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Oct 2022 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJRO5G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Oct 2022 10:57:06 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D958D995E
        for <linux-pwm@vger.kernel.org>; Tue, 18 Oct 2022 07:57:05 -0700 (PDT)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A5B5A3F56C
        for <linux-pwm@vger.kernel.org>; Tue, 18 Oct 2022 14:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666105023;
        bh=BafWgVTs1Qs33lQ5vYE0lEluRGQS0XS1I2Mm/0y61yc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=nvieWA7ecqk1iPZ7FGKoQ4IC39MhPICh4b9ueBWUnPeJF9vARPzvkBQBDnJL2y9Rz
         d6c/PAgZ2Y8VBNfnNYkvyF32CYsf/gDN/PKnYoqoqwErjaLh48wn7o9jLxazuQbPKo
         aSKUJBXJ3ELNUqhqs1LkCmZfr0bloHc9McwldzTrIugwbHdaj69GfzfsZtLD86Ly+W
         o4l9Z3R6plLoCyLN5PqozOmMsN6VnZ5DXeABZwxzTedsrrWRdWKXsNEbz7DagQyv3X
         ADpoPp59SU3N+uSQgyQaDqRJmnHBBQ87Om+pPj6I5aNWXjtbQkR9C/Bnkz9/YgkErr
         J8AuByL+gWzaw==
Received: by mail-qk1-f198.google.com with SMTP id bq17-20020a05620a469100b006eeb0bbe02bso12379740qkb.5
        for <linux-pwm@vger.kernel.org>; Tue, 18 Oct 2022 07:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BafWgVTs1Qs33lQ5vYE0lEluRGQS0XS1I2Mm/0y61yc=;
        b=2REieHhrfXYlvqbs3GRsf0JlElQqYchi2/xR3/D5px/0OWZOI/harpeEB8ex5CnqzK
         2eb/VXZuC9QgYjughJPLxLblVAB8xfLCM1W+2ZH6bkrm7BhceTzqwg+f0TP+7TodBSgV
         h6xdUmJ3Qp5FpXpW8LrbmvLUd1XG3XGuUk9Ub+9tgOwwlCbOrvPfvttR+O8UQuxqVYx4
         UyV3dkfzc/68EOXXNWkvDlwXHUud7MausLmI1FiRxZIm+7GSAO2Dxm3GC6fb2UtyFiqI
         ehbRuiEeOPwkXGvrV2AfgQngqm9ZD5VQyIgJYnIsZ52iqZwHESNQ87R16tne8IXkCn7j
         ESLA==
X-Gm-Message-State: ACrzQf2tz3Y7eKWoEgseFCTX+2V+5oMPiqjJD1yH0ToAZwmR/D9zbli0
        rn4q7PgNrHLJysdgbnEwPxLfpVIiBuN7jfItg62Q6APQ/EUVVp/koLgn+V4vEvVu4c/MamQx+iG
        hpAQXu9tO4jIHFRKgrmKc6tu6HE7QSZMj3uzdLLVv51a8OiXOtq9g5g==
X-Received: by 2002:a05:6214:2301:b0:498:9f6f:28d with SMTP id gc1-20020a056214230100b004989f6f028dmr2400043qvb.5.1666105022667;
        Tue, 18 Oct 2022 07:57:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5VLAiOfs5ypDxb9bi0mpLfwMnKLT/JanF3CcvFCQOgy+yFhQZHARVCsQs1Lrgtks+5teBsR2NSVjwnI8zDS7I=
X-Received: by 2002:a05:6214:2301:b0:498:9f6f:28d with SMTP id
 gc1-20020a056214230100b004989f6f028dmr2400025qvb.5.1666105022393; Tue, 18 Oct
 2022 07:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221018091316.415685-1-emil.renner.berthing@canonical.com> <20221018132921.5fsbiz254npk2fci@pengutronix.de>
In-Reply-To: <20221018132921.5fsbiz254npk2fci@pengutronix.de>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 18 Oct 2022 16:56:46 +0200
Message-ID: <CAJM55Z_v069EJmnr_nLFx9CQV9HfAOc2vCFv95VSip59zLFvjA@mail.gmail.com>
Subject: Re: [PATCH v1] pwm: sifive: Always let the first pwm_apply_state succeed
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 18 Oct 2022 at 15:29, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Tue, Oct 18, 2022 at 11:13:16AM +0200, Emil Renner Berthing wrote:
> > Commit 2cfe9bbec56ea579135cdd92409fff371841904f added support for the
> > RGB and green PWM controlled LEDs on the HiFive Unmatched board
> > managed by the leds-pwm-multicolor and leds-pwm drivers respectively.
> > All three colours of the RGB LED and the green LED run from different
> > lines of the same PWM, but with the same period so this works fine when
> > the LED drivers are loaded one after the other.
> >
> > Unfortunately it does expose a race in the PWM driver when both LED
> > drivers are loaded at roughly the same time. Here is an example:
> >
> >   |          Thread A           |          Thread B           |
> >   |  led_pwm_mc_probe           |  led_pwm_probe              |
> >   |    devm_fwnode_pwm_get      |                             |
> >   |      pwm_sifive_request     |                             |
> >   |        ddata->user_count++  |                             |
> >   |                             |    devm_fwnode_pwm_get      |
> >   |                             |      pwm_sifive_request     |
> >   |                             |        ddata->user_count++  |
> >   |         ...                 |          ...                |
> >   |    pwm_state_apply          |    pwm_state_apply          |
> >   |      pwm_sifive_apply       |      pwm_sifive_apply       |
> >
> > Now both calls to pwm_sifive_apply will see that ddata->approx_period,
> > initially 0, is different from the requested period and the clock needs
> > to be updated. But since ddata->user_count >=3D 2 both calls will fail
> > with -EBUSY, which will then cause both LED drivers to fail to probe.
> >
> > Fix it by letting the first call to pwm_sifive_apply update the clock
> > even when ddata->user_count !=3D 1.
> >
> > Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com=
>
> > ---
> >  drivers/pwm/pwm-sifive.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > index 2d4fa5e5fdd4..ccdf92045f34 100644
> > --- a/drivers/pwm/pwm-sifive.c
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -159,7 +159,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >
> >       mutex_lock(&ddata->lock);
> >       if (state->period !=3D ddata->approx_period) {
> > -             if (ddata->user_count !=3D 1) {
> > +             if (ddata->user_count !=3D 1 && ddata->approx_period) {
>
> IMHO this needs a code comment. It should among others mention that
> approx_period is only zero if .apply() wasn't called before.

Agreed. I'll add in v2.

> Let me note this is inconsistent. I didn't check the details, but let's
> assume the PWM can implement .period =3D 500 and .period =3D 514 and noth=
ing
> in between. So if the the first PWM requests 512 ns it gets (I hope) 500
> ns. Then when the second requests comes in requesting 511 it fails and
> if it requests 512 is succeeds also getting 500 ns. Hmm.

Yes, if two different consumers wants different periods then whoever
gets to take the mutex in pwm_sifive_apply first gets to set the clock
for its requested period and the other consumer will get -EBUSY. I
don't see how this lets one consumer call pwm_state_apply successfully
but still get a different period though.

/Emil

> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
