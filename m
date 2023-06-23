Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C056673BAA7
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jun 2023 16:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFWOvx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Jun 2023 10:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjFWOvw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Jun 2023 10:51:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17C213E;
        Fri, 23 Jun 2023 07:51:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f918922954so8209665e9.2;
        Fri, 23 Jun 2023 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531910; x=1690123910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsCs8LsHMP5hE51uFL5gb7cWLq1UmneDrAfiny814jA=;
        b=o6/Iz3hStvmRMnHiNqCa0sS8vR5Z0zJ64Rt1pPsuREaHUr4QgBDYqi09KqiwX3wWez
         tF5nR+dGxqpe7wEDzqrDA/UYvGUYZ+2AD+IwlkMR0BN1v+pPvd/P147AnKzHQgNEqMGy
         oO/Jhiy9W+kl+YX2+q4N7GSaWnAceUuExtq4hI95MTLLZF/B5Bysw0av3YednZsjmUcf
         K7IpqsXmosh6A2kATmnc6NZlVO7i5Zb+bNlbVxlToB7l3kLg9RINFtPnaTkfEsYw1yrW
         yOYtbnBye2CaAnoZD9TKll9+oTsUUN+F0NMqTIkWC1DpemLYofc0xhqkwYl7v9KFIqcx
         0vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531910; x=1690123910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsCs8LsHMP5hE51uFL5gb7cWLq1UmneDrAfiny814jA=;
        b=aneT/oFmMG7HQCfwcNB1ClMT2UY7qdnK/LVHdfkU5Z8sP3gaV0ZMvZz6JXatgdEt5O
         sm4GWwdSXLXfuO/QZ3zUBR7GOexLQ6HGSx7opqUHkHpEOtnl4Ur7V3eaip8Vpc4AWsiI
         PlIVAJoPgjlQDF3TguLQ+edL8VHlkG3n4cseH4Sz5fkoSCATgiR0BVo1DFh3TSicM+zT
         sAIcJNWKc8GaU7fxinZ4aYKEhPXJZMki8K9+4XvrKoO7zffwD00//c81/AF0RcOaoG5I
         V1+Km1yEPAG+09qAap0aIXWBPC/OLUDPMO7Yk0DypTWmt5hQXJpCHiZhAHTKwqbME9F1
         2LIA==
X-Gm-Message-State: AC+VfDyN9qVmAlYxQ2NlwFVPrfc0csIpm1HaI48jgIGI30X77qEzfZ5o
        PkYfcXWPx3hHZRzYlyic0Ec=
X-Google-Smtp-Source: ACHHUZ70gFtH4lcp2jQS4FQ6zI/OQIsGhu95c6lzI/2L3tCt8GN0oZACXbXS+XHz+ObxQsvHVen9rw==
X-Received: by 2002:a1c:f609:0:b0:3f9:bf0f:1ceb with SMTP id w9-20020a1cf609000000b003f9bf0f1cebmr6203753wmc.37.1687531910075;
        Fri, 23 Jun 2023 07:51:50 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v6-20020a1cf706000000b003f17848673fsm2577365wmh.27.2023.06.23.07.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:51:49 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: ab8500: Fix error code in probe()
Date:   Fri, 23 Jun 2023 16:51:33 +0200
Message-ID: <168753171969.1191890.2777194498557168545.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ffc1e98d-0db4-4b8a-9e49-eb87ef844cbd@kili.mountain>
References: <ffc1e98d-0db4-4b8a-9e49-eb87ef844cbd@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Mon, 22 May 2023 14:07:42 +0300, Dan Carpenter wrote:
> This code accidentally return positive EINVAL instead of negative
> -EINVAL.
> 
> 

Applied, thanks!

[1/1] pwm: ab8500: Fix error code in probe()
      commit: cdcffafc4d845cc0c6392cba168c7a942734cce7

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
