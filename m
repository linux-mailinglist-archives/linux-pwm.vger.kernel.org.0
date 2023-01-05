Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEC065E15D
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jan 2023 01:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjAEAO6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Jan 2023 19:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjAEAOq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Jan 2023 19:14:46 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7F1276B
        for <linux-pwm@vger.kernel.org>; Wed,  4 Jan 2023 16:14:45 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4a0d6cb12c5so169270727b3.7
        for <linux-pwm@vger.kernel.org>; Wed, 04 Jan 2023 16:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21SkpkdejZgplUjbdzFB/vPQFx1n4uSREX/mlnfia4M=;
        b=eY9RQA4Z4TNZyjBVRWA7eKhRaxqtww/P3wF1uBdxk58oPNXDlO/rVemISMa8JLCkh/
         zEsxAfT/Jnl7nH4hs8JuzpBAvEGhi/mFdPy3mvex0Rp37wxjjff9AS0eFZIEw96m1AL2
         ATx7pG7fBcL1K0tkNBdDc2BtsFxYnNnJKukgF1d9ohXYp2ktE7EKWmjVp9a7slHgeiqD
         88iS4BOmhGUMv5bU8G5PoA7b0++ddklEC+Qj89fqWA80rcnv9+PQ6twED6a0AnuafCQY
         VNe4naUNYqXLUQsmEM8xou/q1/NvwNzdyMpmRZt0KyWQWltlMWLLr6ivAaSOzEfXsobG
         1J1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21SkpkdejZgplUjbdzFB/vPQFx1n4uSREX/mlnfia4M=;
        b=KkjPYT/6ojaWkiV/xak7UIGo26H7pkl8MHdQnAEL3vYr8n2xovGdy6L8zzS8gyyUN5
         q9Hw3CCRRjuLoQ6oe+QYvrd/2bIAbYWtTL0ejrE1Wyb4aGhH9dt31BJRARrxKv2G/nBk
         MZYfNhkyY8Zs0AOb+vQ8HQ5ac8eoSIcQBBjXjH9STSru4QW5zkyWWyk4etRS++7ZibRF
         uxeHRQOU50ze2tp4Tu8pm1ZbInxdP+SrKxPLWUVftOfX8DMVAFObeqVPxjrvcWZH7SMy
         9ahmsamGFiCN4zolp1cs66xrxVRLxfdllb4dRMOOhGw5t7cV2WaF/W27YN1tQNM2C6k3
         X2mg==
X-Gm-Message-State: AFqh2krdcUV9gZgn0mromFl/9MSOKceIeXpTakXQk8j6qapGH4poSOlB
        Z47Ce2CobJWPcAgVD/QChS5dEimw/PPk+rFjw255ig==
X-Google-Smtp-Source: AMrXdXvEHVvJ5rIb0y1oLRtBKcnB9skB4xOCheS4KshuXYm9G20MQLZvlFXqyoSObfwsNYprV/uwAN9ZM95Fn9Krr2k=
X-Received: by 2002:a0d:cb0a:0:b0:474:b3f2:8df1 with SMTP id
 n10-20020a0dcb0a000000b00474b3f28df1mr4409386ywd.434.1672877684502; Wed, 04
 Jan 2023 16:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20230103231841.1548913-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230103231841.1548913-1-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Jan 2023 01:14:33 +0100
Message-ID: <CACRpkdYMUBGOPoS3BUhwv=pwhnPfq94VLsanyBs0J_ajrsq30Q@mail.gmail.com>
Subject: Re: [PATCH] pwm: ab8500:
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Axel Lin <axel.lin@ingics.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jan 4, 2023 at 12:18 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> The .apply() callback only considered the 10 low bits of .duty_cycle and
> didn't check .period at all.
>
> My best guess is the period is fixed at 1024 ns =3D 0x400 ns. Based on
> that assumption refuse configurations that request a lower period (as
> usual for PWM drivers) and configure a duty cycle of 0x3ff ns for all
> bigger requests.
>
> This improves behaviour for a few requests:
>
>   request  | previous result | new result
> -----------+-----------------+------------
>  1024/1024 |          0/1024 |  1023/1024
>  4000/5000 |        928/1024 |  1023/1024
>  5000/5000 |        904/1024 |  1023/1024
>
> (Values specified as duty_cycle / period in ns)
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Looks correct to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Believe it or not but there is a hard-to-find public datasheet:
https://web.archive.org/web/20130614115108/http://www.stericsson.com/develo=
pers/CD00291561_UM1031_AB8500_user_manual-rev5_CTDS_public.pdf

These register bits are described on page 282-283.

Yours,
Linus Walleij
