Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C74763F43A
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 16:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiLAPjC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Dec 2022 10:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiLAPig (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 10:38:36 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DCC837F6
        for <linux-pwm@vger.kernel.org>; Thu,  1 Dec 2022 07:37:56 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n21so5081012ejb.9
        for <linux-pwm@vger.kernel.org>; Thu, 01 Dec 2022 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs63CknEsiv/WVfdwhEf+CjJpYFuCYS7MFFgd+vKinI=;
        b=S5Cph6OJnAgWEqs4wshrH9YtIgA9gzbuit6FFWjRz5kQkGt/lnkopP+J02/qQQf6N/
         I8Rg81mjT6pSpWVksuoQEc7iStoxnWkcplJhRXI+4UjVA9A6yboKWZX/vvcS7W8GxPnn
         o/lcQs66XO4njeb4jo90uhC/oe6GRw0VCvzH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qs63CknEsiv/WVfdwhEf+CjJpYFuCYS7MFFgd+vKinI=;
        b=Lx2UUeGGQTyinFasbObuBo113DUCdxD1xxiIaCbwb5BeuVXc/L2ELwuTa1S7iANWse
         ZWebZoWKuS9pKwMb7xuZUoNa2NFt8nzBpiYnIB1n0Ugkp3sOJQtpI40exI+WIAuuephC
         C6nVLGhU9x3QNZ7NV3bHq3p01tnjL76elB5Vn/T6mfEOf6HGJs7HRsD+Q19zDDRumJwk
         Ai1JtSRYo2lyxXUHIb1KMXjZAHRC3CcWvc38Df7AFJ/To2jGZUnOKU6eMJbFLd0jnJhU
         iNZ/WQFM/oukQ/ezhHiWVHfb7kHr2AbHNg3KCNqUfaanWbDFAZ5JpImdoxD1wXZybXUg
         bJAQ==
X-Gm-Message-State: ANoB5pkuIpWikXN707mZjhbLbKFaQgpq8CtsCc55d+EPSCqlhYGuBRjx
        qsYWBzvb1VmOnP3uYuV7wITS0JldctDDCLdp
X-Google-Smtp-Source: AA0mqf4K3+I2zGGhw4gjYowTJie8L0yaDiJU8mdZcI3Wbp9tyAgSwFbrfU6S1IELfYxi302NJ7Fthg==
X-Received: by 2002:a17:906:a983:b0:7b8:31b1:b23f with SMTP id jr3-20020a170906a98300b007b831b1b23fmr39934791ejb.591.1669909072856;
        Thu, 01 Dec 2022 07:37:52 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b0077b523d309asm1867307ejf.185.2022.12.01.07.37.52
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 07:37:52 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id t1so1438997wmi.4
        for <linux-pwm@vger.kernel.org>; Thu, 01 Dec 2022 07:37:52 -0800 (PST)
X-Received: by 2002:a05:600c:1e12:b0:3cf:9ad3:a20e with SMTP id
 ay18-20020a05600c1e1200b003cf9ad3a20emr38995897wmb.151.1669909071906; Thu, 01
 Dec 2022 07:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de> <20221130152148.2769768-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20221130152148.2769768-4-u.kleine-koenig@pengutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Dec 2022 07:37:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uoy6fg2qDeU-Zz+3UhVdWEQzf9XWFrZzmoUyJ4=_U3VA@mail.gmail.com>
Message-ID: <CAD=FV=Uoy6fg2qDeU-Zz+3UhVdWEQzf9XWFrZzmoUyJ4=_U3VA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] drm/bridge: ti-sn65dsi86: Propagate errors in
 .get_state() to the caller
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Wed, Nov 30, 2022 at 7:22 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> .get_state() can return an error indication. Make use of it to propagate
> failing hardware accesses.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Douglas Anderson <dianders@chromium.org>
