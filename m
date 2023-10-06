Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C507BB35B
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 10:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjJFIiF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 04:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjJFIiF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 04:38:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5B2BB
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 01:38:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ad810be221so320003366b.2
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696581481; x=1697186281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wj4Zy/s4g5o2t9zfXyZUuq0sKsd6wJsRfPq9hO/m7fw=;
        b=mAjjMSxKJJ/nAZFPvw1/ppxMrxCJzgv0sX3n3pxfakdXBjh1T5llznKHWuJNo++Hjh
         hduCDUc7WFX4XqtTY1S9CxQDyHBF62B8YtYWEHVZPIyXF0JniiJaSUqBSlnpYffo43XM
         HDZWLVtAa2ah9vnTECN+N5I1YCVtJ5ZVcygBaKEIWjfQrvtfpu0/rCw2W6Vni8Njklg3
         Cm+vDJEeqiClCU9bQZaqD6M+Y+lrhmeQEJA2euibDVCtyCxzWVPbLVIXRuNc/AHP6+gE
         jaJ905HoVWmv8mqCkf7DUbLlfQN8iSyCqIJYXpmpzWbQZhAN9Ndwgjajhfcv3mNdpYK2
         OBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696581481; x=1697186281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj4Zy/s4g5o2t9zfXyZUuq0sKsd6wJsRfPq9hO/m7fw=;
        b=sNSX5oApg8iyKxydAE2ED4lO4eHEwhuMiXk86ZrGThgoMOpO3JRaDGpuLhHLQuhdr/
         r3c1WBy1IDiuC6i0OCaSkuwbMzb4EwKK4ozfr4cLWJse1GEDg65mhJbSKKUp8o5jmy5i
         E25tU2OdNsytslk1Xp9k/eYoGOego3nGGI62HEVCkP1ghF2ad/NdO2EvWC/ghiwMper6
         d1e7ubnzN30PDD3t8Kp8toc/D8nqUQ0YIeHY6oL+zoWjxi2jEo7Tj/g0VGS/EAPT4IBI
         pkru2Nco87AUsUJwbq5M4+pE29LVFghMknZb7S6Xq/aaf3O2FtRrfEz3gwhZr4w/T/AF
         eoIA==
X-Gm-Message-State: AOJu0YwUSF0vS9H0cUX0YuME9BgEMDOqR1tHCQcpoHU9MlFzd5oZ0K6H
        RRCl6edt6y57tppKamZSA64=
X-Google-Smtp-Source: AGHT+IGjKRZppjUDKag4sbgu10zuF0hE2WMQN2Ezg5NfV0jn9fIejSrVTItJuXuiVzFyrmyA31T9YA==
X-Received: by 2002:a17:906:530c:b0:9ae:3f69:9b8c with SMTP id h12-20020a170906530c00b009ae3f699b8cmr7454739ejo.2.1696581481039;
        Fri, 06 Oct 2023 01:38:01 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709064ec300b00997d7aa59fasm2559878ejv.14.2023.10.06.01.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 01:38:00 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     claudiu.beznea@tuxon.dev, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Ruan Jinjie <ruanjinjie@huawei.com>
Subject: Re: [PATCH -next 0/2] pwm: Remove redundant of_match_ptr() macro
Date:   Fri,  6 Oct 2023 10:37:58 +0200
Message-ID: <169658146444.77951.10429432306521362349.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230810074258.2390629-1-ruanjinjie@huawei.com>
References: <20230810074258.2390629-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Thu, 10 Aug 2023 15:42:56 +0800, Ruan Jinjie wrote:
> Since these pwm drivers depend on CONFIG_OF, there is
> no need to wrap the macro of_match_ptr() here.
> 
> Ruan Jinjie (2):
>   pwm: atmel: Remove redundant of_match_ptr()
>   pwm: omap-dmtimer: Remove redundant of_match_ptr()
> 
> [...]

Applied, thanks!

[1/2] pwm: atmel: Remove redundant of_match_ptr()
      commit: 2992e07038aa38e1e156a833d6274bf330642722
[2/2] pwm: omap-dmtimer: Remove redundant of_match_ptr()
      commit: 7818f0bcc195e7c49eaaa031f0c26c59978469f6

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
