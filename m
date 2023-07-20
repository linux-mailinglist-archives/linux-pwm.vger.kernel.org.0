Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5975B169
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jul 2023 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjGTOl0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jul 2023 10:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjGTOlZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jul 2023 10:41:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C9910FC
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jul 2023 07:41:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991fe70f21bso148273166b.3
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jul 2023 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689864083; x=1690468883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLrHxYUorj4cRATSl4FYWOBY6cgIskL8/uHYHedoFV8=;
        b=gWcKKtu+NPxLWPKoWi3l0E4hcgurpq8rsryPV5UeUd/jTyTcdlvtGzb8gh0vph929W
         hr/RMZNCEsxLG3NWBSl60PCuiWYcdsfPONdHgFdAOnDMUgDNA1qOo8kUP2AUFiJiMcDf
         UKtBS/ErkKBVFXl2mZncl0VCjfxioeF1wCFhisv/VGv0JbxKwdQHnjdMPtQl8dpjxT6I
         ccyE8q9NPMzASWLBYhw4sR4Pzu1xv2BMCVLl+k0kZzQkNDpSaiv7UzSVPpeN6wSITaAf
         ZXLIBD5HlyMKXxRDkrj7j3QZ1sgaderLBP6XGfHj0oYi4LU4XCdssHqdMFcQCOiWQo+d
         QWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864083; x=1690468883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLrHxYUorj4cRATSl4FYWOBY6cgIskL8/uHYHedoFV8=;
        b=kwnsOAUAcg40NwmOVUVZ9+NNFWCvCaYgC0coNofODkSBRFATxGXZc+LXibLvI98knM
         BEWxqcTs0LKz0UpECcpUYVlPPh+DEIKBoJtjiCDW1qMF2a89HtIhSdJswTR+idj5R3Ph
         ZybLLPNLIrsi3kRxEIDG5mmch47NCHDCvRIaBfNH0wbeEgl/BYzsVuvE6ymLOa8Dl2/e
         M6je31L/QXcE1fQ+SCTEakEYweIopmXXqs0vA+Mo+J+FIyknFaxTVOy/UksGXHvRCtR6
         /ZCsFV9KSoBiisCFFqNILrLuIgZ9EOliRViv1H0hSYnVFbhZNyoWopHmSGmXlsnVa+eL
         jT6w==
X-Gm-Message-State: ABy/qLafQ6cWg9FluUstngdHdH4BNKHAoi7i1PG5uVutygyMnGhQtljj
        nFAsC+Ig/6k1IUSOsDzPb+M=
X-Google-Smtp-Source: APBJJlHgueNlqW0haDo5hRGUxcvhVV7/ihvmmvg/gwqzFV0iohHNBCeqNUuKd8ZztzBQESq59FBD8w==
X-Received: by 2002:a17:906:8488:b0:970:1b2d:45cc with SMTP id m8-20020a170906848800b009701b2d45ccmr4904840ejx.57.1689864082442;
        Thu, 20 Jul 2023 07:41:22 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c11-20020a170906924b00b0098e34446464sm799399ejx.25.2023.07.20.07.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:41:21 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Benson Leung <bleung@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 00/10] pwm: Constistenly name pwm_chip variables "chip"
Date:   Thu, 20 Jul 2023 16:41:16 +0200
Message-ID: <168986404868.1519829.8131310221840364014.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Fri, 14 Jul 2023 22:56:13 +0200, Uwe Kleine-König wrote:
> while working on an extension for the pwm framework, I noticed that some
> drivers and even the core only nearly consistently named all variables
> and struct members holding a pointer to a struct pwm_chip "chip":
> 
> $ git grep -Pho 'struct pwm_chip \**[a-z0-9_]+(*nla:[\(a-z0-9_])' v6.5-rc1 | sort | uniq -c | sort -n
>       1 struct pwm_chip *pwm
>       1 struct pwm_chip pwm
>       1 struct pwm_chip pwm_chip
>       2 struct pwm_chip *_chip
>       4 struct pwm_chip *c
>       8 struct pwm_chip *pc
>      57 struct pwm_chip chip
>     358 struct pwm_chip *chip
> 
> [...]

Applied, thanks!

[01/10] pwm: Use a consistent name for pwm_chip pointers in the core
        commit: b4f78ff746ec5274fffa92fa2a4dc531360b5016
[02/10] pwm: atmel-hlcdc: Use consistent variable naming
        commit: 509143926e184762cdaffb6b67d3809fddd7f4d9
[03/10] pwm: bcm-kona: Consistenly name pwm_chip variables "chip"
        commit: af87385c7ad278207d34ff3681fa325a240ae87c
[04/10] pwm: crc: Consistenly name pwm_chip variables "chip"
        commit: fc30826d50d10d67628addfabb9367b5067efa42
[05/10] pwm: cros-ec: Consistenly name pwm_chip variables "chip"
        commit: 6b5fdb2b655ac9abe6fbd2cbcb25c8837e3e8553
[06/10] pwm: lp3943: Consistenly name pwm_chip variables "chip"
        commit: dd499b63618e523b47f30d99bf20f417de1187ff
[07/10] pwm: rockchip: Consistenly name pwm_chip variables "chip"
        commit: 8c297d1fdb5d2b81d39ada6b435fb92a41be9f17
[08/10] pwm: sifive: Consistenly name pwm_chip variables "chip"
        commit: cb69f40ea7cb139223901fcfc81e4e0a0a03673c
[09/10] pwm: sl28cpld: Consistenly name pwm_chip variables "chip"
        commit: e79974c5c3ddc3e8181f582117c4368557524f20
[10/10] staging: greybus: pwm: Consistenly name pwm_chip variables "chip"
        commit: efd1d1ad7f525809fcdf7538638a08274b75c99f

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
