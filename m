Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7BF766561
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjG1HbI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjG1HbH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:31:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED9E272A
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:31:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52227884855so2589883a12.1
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690529464; x=1691134264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9b6sGYWc8qgYu3rKbyk/6ze6PdD/tBu1uPkV2EbiEM=;
        b=XCNJvsVFM96XBQknaGY+2KqPFi/QPQOtqSMSWVfqqtv+hhyrc/KP0/vb+ZbXewg0Ly
         3VSgHzTdJu4I2KtXf/p8p2092TBd3rgs9tsvBXZ5zVrN90bHYbTRt18yTvrpFtk3Xmdr
         zk8FdtLaV9M3ePvcXH6GnQDqPdyhT+dmlfEZMwRRX5V/uBGwtGi2qcbF/P320RztwB5E
         4olW9ijmuiFtnX+Nec7jbZS9Eec/N7gZzbqtSQV1HVCJptyXp13cVAIZLev/ur0oWgel
         ypuFb62BTyMudVuKL3QLnbkx3c+WU+y1VWw6D+LXCrENVxnOczVph43kVxPNtx7wnM5Y
         wtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529464; x=1691134264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9b6sGYWc8qgYu3rKbyk/6ze6PdD/tBu1uPkV2EbiEM=;
        b=CwLfDxaVCcFuHU0U5/4xlYvIp3XLl42QOZJQjMs9+m7Juw6DbysLta4gHxLuDuXhxH
         LdxQQ2yzlRfnrszMTvuU8kjHgTz1+eYn0WtoMY++YHJT6cC8JISg40wS34dcMX7DIRYJ
         aEJiWk8tjY15NLfU3Srvi6zexkTcMHU1AOYBK7XigQ+NEdl1ldZ+E3mhZzwbkyiLl5yz
         ysG98CXN8dDQExTCz0Q5STR3uGhqwwMjB13IFERYsgpJXWkrJDX9CkPYZYjxdtlWPVVz
         ERzoX9gXb60hpS4J0UBV0ifJALx7MIMKopKgi89UE7UeJWV6z7bOWaLqcRM8ZrEDhs+/
         pqwA==
X-Gm-Message-State: ABy/qLa3HWSPsel/pRSnCssmfDHgUv/6Xx+1Ns7Yp+2wV4xdmPhRrChq
        wDlQFDfBg53thGt0vv34SEnoDJ2od9E=
X-Google-Smtp-Source: APBJJlFuAKZPhhEGwkAKWVJxFCb9zHYhZIOZ3bRyNwd2j9h3ZlrlKv5H3iUZM3ndVc5B9Y/0N1fugQ==
X-Received: by 2002:aa7:d903:0:b0:522:5799:d5e7 with SMTP id a3-20020aa7d903000000b005225799d5e7mr1324669edr.26.1690529464354;
        Fri, 28 Jul 2023 00:31:04 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640206cd00b005223fb6d511sm1484208edy.28.2023.07.28.00.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:31:04 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Remove outdated documentation for pwmchip_remove()
Date:   Fri, 28 Jul 2023 09:31:01 +0200
Message-ID: <169052945391.3512110.15372315057064226621.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725081945.396310-1-u.kleine-koenig@pengutronix.de>
References: <20230725081945.396310-1-u.kleine-koenig@pengutronix.de>
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


On Tue, 25 Jul 2023 10:19:45 +0200, Uwe Kleine-König wrote:
> pwmchip_remove() returns void since some time but the documentation still
> mentions the situations where it used to return an error code. Just remove
> this old and now wrong text.
> 
> 

Applied, thanks!

[1/1] pwm: Remove outdated documentation for pwmchip_remove()
      commit: 018121e655c8ac2b369f70758dbddf7a37ef534f

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
