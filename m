Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37C658851
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Dec 2022 02:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiL2BSU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Dec 2022 20:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiL2BSS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Dec 2022 20:18:18 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E0213F5D
        for <linux-pwm@vger.kernel.org>; Wed, 28 Dec 2022 17:18:17 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-15027746720so5245023fac.13
        for <linux-pwm@vger.kernel.org>; Wed, 28 Dec 2022 17:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tF88S2Hv4sGeYM0IJIhlaIGexQCWBfknOiRvMdfr8IQ=;
        b=ErJOFlw0/sxpSqS5/yP6KnCa/ipcN5aykXU3V/tUmwx5KFRj7Xlc7+PimX2rk3AbZa
         nvYV82wqQgN42DHllbPXiPLydrZBhAGJbHPYlN/GDgX071J4I1uSqGJNGVH1OMrk9Q8U
         QXKbdbVAlD5AAMieHpAKJ/nNtyI2+v0KsAuP9nfC8J9+im7sN0imPVgdSNBME2Tz4K0J
         wSMT2j2IbN23iejfo9O/2LzVuGOP0IgR5rBVmJ68DHvY0keaqzIs93EPyfd72GHTJ551
         7pp2p15x7RPeugYnimzuygdWdQHb07QT8ymXvlg++xza77108AVviR7rfT0s/g8h53pq
         2GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tF88S2Hv4sGeYM0IJIhlaIGexQCWBfknOiRvMdfr8IQ=;
        b=GzxTvqXukV8BjPIcuc4SKii3+M7xDfQ/f0vtRnZPmRs2tIhP+40lEsaKEoC/Wb1ppc
         WHyhl4v6I0kD+MfkfNLrqEgkgsJkZ9mZn6BpIWZkuKmJL85M7dWGe7FlczAAXeXVwnbM
         pPZ+6Fwpc5atgftNTJ2+gtMIHAUGv1MnbnKzmdVnJaLnhl5r0N4XW6XnXG0fBNHCotE6
         vO4Zmjr6imIDSdywqIcZ1m9XFyylY1PgvMVTPDURWasIDkvSkX3ZbTTsvcbWd4+02f0Q
         UDuAzs5PckauWnxNEJFUwH/HFtRrlkyJlIYLYi90qJtP/1kx9eTpwqHDJQmTrXz1yM06
         M7qg==
X-Gm-Message-State: AFqh2krSAgzDVAlrbrm9jOe331VNGR2LMQ1vrsAdIvtm40Q326FJ1Lgk
        /KAJMUnnsyGrCWw+DVmCfUp1LkCh7tg3U0uSP3jmPA==
X-Google-Smtp-Source: AMrXdXsVwziQundR1fwbIB4yBVcJ+hmaEtqLmbyZ5bauQjKbV7xMCLbbZvo+Th31AipBIbAj3PSQkJCNE/ow1xf8mmw=
X-Received: by 2002:a05:6870:fd89:b0:14f:ede2:db25 with SMTP id
 ma9-20020a056870fd8900b0014fede2db25mr904396oab.42.1672276696527; Wed, 28 Dec
 2022 17:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20221215213206.56666-1-biju.das.jz@bp.renesas.com> <20221215213206.56666-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221215213206.56666-2-biju.das.jz@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Dec 2022 02:20:10 +0100
Message-ID: <CACRpkdbBua9-0o+vK1mWeQV9pr=1DE100AE7cdymEyhZQY39QA@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: pinctrl: renesas: Add RZ/G2L POEG binding
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Dec 15, 2022 at 10:32 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Add device tree bindings for the RZ/G2L Port Output Enable for GPT (POEG).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch applied!

Yours,
Linus Walleij
