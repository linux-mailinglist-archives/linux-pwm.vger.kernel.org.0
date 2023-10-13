Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CDF7C86D3
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 15:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjJMN3u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 09:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjJMN3t (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 09:29:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA2BF;
        Fri, 13 Oct 2023 06:29:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ba081173a3so349559866b.1;
        Fri, 13 Oct 2023 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697203783; x=1697808583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzg3arDSnTgx9Lh5/L+TCT0XkQL6hfP1PayFQO5ztB0=;
        b=Bz2+FEnYdBCwjT0J5nJ1jnD8/85jy5znPPhDvrh5BGnR0E6qkMBPOTv+I95tMpF4Ku
         xqI0EGkwReaNYkNluq4t5CQjexfAOADX/uCZbIPir7t4dYUoSEKKhbpAshtZ+6HGnV7u
         nAJ5sYEnu1kD7jJUhsY4KKGgPseygPBN27q7DQPB9L2z4BPEHdJ9OgvObMrx23d4hCUO
         KvdufG1AH7tPJDLzot/0H20u1k9/wzWjyM5tKC2bmNlYiZ+uuCwuP1/sS8zRfMnok8S7
         LB4/PqJ0SrVGilOE2CvS+XVDkDjieeEz+EUbAZl5tL/fy4Tq8W2Ky07gTPkwYu8UNUaW
         3XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697203783; x=1697808583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzg3arDSnTgx9Lh5/L+TCT0XkQL6hfP1PayFQO5ztB0=;
        b=O5RYqKJvtnayQpxICOaFwoIlIY5K4bAHq/jj7Gx4ne5LpB90XjL3AvpWH3csOZfUXI
         lnTm6r9W3HlJYtk/kkp8cs8uxmP2RmX3otnRALURiSmn+fD/4P93fmxTwI3GVUwbKeaJ
         nGoUh73T5VdObod1q+3LKWe/9LU3hGbJa8fpjilFvuc7mH/b1qBwp4U8TnisuI6pGg3K
         +WdFQWPe3tfCdoeRmcV4BzzZr2xyxzgIszmlHaC9XEN1kglz55anYQpmkIsWqZ08dS37
         okJQhFgmjYaN5bSXKuwhFAcn01g2x4g3xCuVvX113/WsicQNsN3Gwa59/5MAbI1b1Csc
         pC2A==
X-Gm-Message-State: AOJu0Yy245hrexk25Fxod0PUpoVbkMjN/+KQF6FvIesfjIVAcnLHp4sW
        7NkiTMlELmZzmODyvNJhK30=
X-Google-Smtp-Source: AGHT+IFLNY3lBhAg7rxUVOJ1znAqlSnHRe1P7lpJz/Euy4Yb8Tu2B67prK77PTsicnsE0rN4valR2A==
X-Received: by 2002:a17:906:3ca1:b0:9ae:55f5:180a with SMTP id b1-20020a1709063ca100b009ae55f5180amr23129597ejh.9.1697203782959;
        Fri, 13 Oct 2023 06:29:42 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709062b0600b0099cb0a7098dsm12636161ejg.19.2023.10.13.06.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 06:29:42 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pwm: samsung: Document new member .channel in struct samsung_pwm_chip
Date:   Fri, 13 Oct 2023 15:29:35 +0200
Message-ID: <169720375693.285367.8034783567173304872.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012210228.1009473-2-u.kleine-koenig@pengutronix.de>
References: <20231012210228.1009473-2-u.kleine-koenig@pengutronix.de>
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


On Thu, 12 Oct 2023 23:02:29 +0200, Uwe Kleine-König wrote:
> My earlier commit reworking how driver data is tracked added a new
> member to struct samsung_pwm_chip but failed to add matching
> documentation. Make up leeway.
> 
> 

Applied, thanks!

[1/1] pwm: samsung: Document new member .channel in struct samsung_pwm_chip
      commit: 4bb36d126cb3147d6bbfd00242a5b846dacad595

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
