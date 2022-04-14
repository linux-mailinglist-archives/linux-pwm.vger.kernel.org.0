Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8854500CDB
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Apr 2022 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiDNMSj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 14 Apr 2022 08:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiDNMSi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Apr 2022 08:18:38 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFF65549C;
        Thu, 14 Apr 2022 05:16:14 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id o18so3358134qtk.7;
        Thu, 14 Apr 2022 05:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C59spLPxwzH4gGgHuafvnNS0cSDR8MdvsbhPT9uuuXo=;
        b=wPKoqPkfypjZVkTQw33dmno+BH/iFki/Ddq0lgP9OXXoNxUs2YEYw8i8UHq0Im/CMP
         4Mk2i7+iLyXCV7Qu6qPRk8P4xNxBcv6wS3F2mCWm0IOEyZtMAbetFd1vkO6ZXWrfrzUo
         PO2Z3cVLCRPoExWXaU0qBoy2ONxuulN1ZnOsjhLt0IDEuX5q7wH54dU8bwhpED0vGq1Y
         4VIcWLM6l/QxZmmcjlNDiUxvMfIcRgOlfp4Z1A2L5DP5J3dBq4KPu74Od7/Kdu5QPL6h
         6q7Mf4UcmxWscv2LK/on683LRn9G+xxtNYv/QY1cSM+zQAbA6oZhaT1VuTOeUTa+Xu8X
         gdCw==
X-Gm-Message-State: AOAM533Hm1dmhx2+yKDdnLDjgLgFUrNgG3dGCJ7p38Vgz/vYHpdIXkTh
        XdlMB52Jw2fzVUPvF80DBT2i4ZYAogo2qA==
X-Google-Smtp-Source: ABdhPJx00E7KM6k52HtD+q0NXxFL0geQJQOGIP6Lr/oRdP8i8dUrFFNQwBuenGW/o3slBvaZ2mPyIA==
X-Received: by 2002:ac8:5a16:0:b0:2e1:ea00:b4e1 with SMTP id n22-20020ac85a16000000b002e1ea00b4e1mr1439699qta.329.1649938573266;
        Thu, 14 Apr 2022 05:16:13 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a188300b002ec90a0ecc7sm996693qtc.59.2022.04.14.05.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 05:16:13 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id h8so9002517ybj.11;
        Thu, 14 Apr 2022 05:16:12 -0700 (PDT)
X-Received: by 2002:a5b:24e:0:b0:63d:cba0:3d55 with SMTP id
 g14-20020a5b024e000000b0063dcba03d55mr1379637ybp.613.1649938572676; Thu, 14
 Apr 2022 05:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
 <20220413085050.61144-3-u.kleine-koenig@pengutronix.de> <CAMuHMdUsmjjKWBWNWr9DCmbWM8CJzXxDbcpjzystYhT3tgFtjg@mail.gmail.com>
In-Reply-To: <CAMuHMdUsmjjKWBWNWr9DCmbWM8CJzXxDbcpjzystYhT3tgFtjg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 14:16:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVzyZMdTciqscW8r8+9qpyFUJkKs10O8fsOa++tvc3LxA@mail.gmail.com>
Message-ID: <CAMuHMdVzyZMdTciqscW8r8+9qpyFUJkKs10O8fsOa++tvc3LxA@mail.gmail.com>
Subject: Re: [PATCH 3/6] pwm: renesas-tpu: Implement .apply() callback
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, Apr 14, 2022 at 11:18 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Apr 13, 2022 at 10:51 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > To eventually get rid of all legacy drivers convert this driver to the
> > modern world implementing .apply().
> >
> > As pwm->state might not be updated in tpu_pwm_apply() before calling
> > tpu_pwm_config(), an additional parameter is needed for tpu_pwm_config()
> > to not change the implemented logic.
> >
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> The display backlight still works fine on r8a7740/armadillo, so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Oops, I spoke too soon...

> > @@ -366,13 +366,45 @@ static void tpu_pwm_disable(struct pwm_chip *chip, struct pwm_device *_pwm)
> >         tpu_pwm_timer_stop(pwm);
> >  }
> >
> > +static int tpu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                        const struct pwm_state *state)
> > +{
> > +       int err;
> > +       bool enabled = pwm->state.enabled;
> > +
> > +       if (state->polarity != pwm->state.polarity) {
> > +               if (enabled) {
> > +                       tpu_pwm_disable(chip, pwm);
> > +                       enabled = false;
> > +               }
> > +
> > +               err = tpu_pwm_set_polarity(chip, pwm, state->polarity);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       if (!state->enabled) {
> > +               if (enabled)
> > +                       chip->ops->disable(chip, pwm);

tpu_pwm_disable

else it crashes with a NULL-pointer dereference (e.g. during system
shutdown).

> > +
> > +               return 0;
> > +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
