Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BCF7BB3C9
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 11:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjJFJFd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 05:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjJFJFc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 05:05:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF5E95
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 02:05:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so1832453f8f.1
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 02:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696583128; x=1697187928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3y5sWS6YZw4dHV6FcRIFvj6enMdplXY9aYDW/4ZxVk=;
        b=eP+0SOlY0xFkSI+MaJUQjYtgFwqD8MvdCqtpqVydeDFtWkycsUpsbVb4nvpBUE0EsO
         AFgcJlESle4doaLH7DNDiXZUYMR42GGCVVP3D89iOu0Ueq//DpVJdStx25P0LaKpX0dk
         qCUGc3u6iHb8xCOJ4myH6zBacvUzzvjRleQi/qcpEivj2ASi2gJ5qT7uGG7MqoYzcCb6
         EhYGL+gkWEJhHrzW5aSgAGhh3NMSi5cr68qFzZNQabzaOddVl8fkeRIiLNDRt90GGWSr
         6Kw6M8c48bOQV5HCvF/87XIXiBMEIqBNPpdOL7X2WjQxZGH9KvP1EMdDrxoIIdjZisw8
         9sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696583128; x=1697187928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3y5sWS6YZw4dHV6FcRIFvj6enMdplXY9aYDW/4ZxVk=;
        b=eurDM3VBCGsfWAlApKOQHMk++WtQOlb6i9CSDA4qahMdES3WTxSojTduTgWlGmyN/J
         MzwlmVSU2PLbdY/uGMlgGbzCNpNzEjWJc9o+cqAeHViOUUB0ehN+qyWq7BEtJyjZ56RB
         Yah1+QQTVdVdvpkOT8sebotJ8JmaZNNCkb8REvRRS2G5/h6++mH29UGL++7jdury2pQ4
         MS6q3jT6U/k7dxl6qqbOVWbnWCWaxjgcyc8KZati7dhi1e3VCseIA6GTAeOg6Lt8/R4G
         QuXbqGfvXK7MX1pAJb1xVWDXU4KesexTVOejf2YmMGwmqXNIcJoVHzGer7z6B9J3P6HV
         rREw==
X-Gm-Message-State: AOJu0Yz2FdoZAgqtazSu3rkZ0KQDRAmkzARRMfPcVAN2FEuZIMmKOed4
        LCTFMl7l1rsNVm9P7ujo7iRC+gBNVQk=
X-Google-Smtp-Source: AGHT+IFn8cv3MdIOSkJ9RnPVwSrATDxtPBvCahxfgYKn9bIMfKj0O7ZrDELJBYqXQ8eHhiSuGNHh/w==
X-Received: by 2002:a5d:58ed:0:b0:31f:e026:30ac with SMTP id f13-20020a5d58ed000000b0031fe02630acmr7137352wrd.34.1696583127750;
        Fri, 06 Oct 2023 02:05:27 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e14-20020adffd0e000000b00315af025098sm1178718wrr.46.2023.10.06.02.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:05:27 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     linux-pwm@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     conor@kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1] pwm: microchip-core: convert SOC_MICROCHIP_POLARFIRE to ARCH_MICROCHIP_POLARFIRE
Date:   Fri,  6 Oct 2023 11:05:25 +0200
Message-ID: <169658309151.79542.7783579028075186099.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230918-finisher-eliminate-b9cacc9d86eb@wendy>
References: <20230918-finisher-eliminate-b9cacc9d86eb@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Mon, 18 Sep 2023 11:23:27 +0100, Conor Dooley wrote:
> As part of converting RISC-V SOC_FOO symbols to ARCH_FOO to match the
> use of such symbols on other architectures, convert the Microchip FPGA
> PWM driver to use the new symbol.
> 
> 

Applied, thanks!

[1/1] pwm: microchip-core: convert SOC_MICROCHIP_POLARFIRE to ARCH_MICROCHIP_POLARFIRE
      (no commit info)

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
