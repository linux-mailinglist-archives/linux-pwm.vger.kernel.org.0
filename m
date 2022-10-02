Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B895F2186
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Oct 2022 08:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJBGSh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Oct 2022 02:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJBGSg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Oct 2022 02:18:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6916F4F1A4
        for <linux-pwm@vger.kernel.org>; Sat,  1 Oct 2022 23:18:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 3so7363110pga.1
        for <linux-pwm@vger.kernel.org>; Sat, 01 Oct 2022 23:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yGybMVex3OsDeUH1H6jlG9I5s9sFp3jqE7ssAcZ/nS4=;
        b=dRd+InvVluZ+/SMJXOPeNJL9ZKbLlW9saU9yB5AXS75loY3GKDeUsnMMWQTs+O6PF8
         GoibaWpIqPX+el42wI1JjCgyKrua92rBZ/9oOHvcKRJNtoqTkAwf9yWSztb9/ewt6Tyo
         PGqswaHfDQj1AxtJSVSlcXE3d9YYK0dfZwnMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yGybMVex3OsDeUH1H6jlG9I5s9sFp3jqE7ssAcZ/nS4=;
        b=SvkyXInygOTlJUuDuBX/WIw2TlpDD6HuPjoMo2/13eCgLfWxytr7nBIMUnyxQpCk0B
         GGCgGwwPKzufZEHeOBT4jNx3+8DPkApaG00/s6uLqZibHS95FvSywheBjdWm4/b8qyj7
         zTFCtqJvgkRgW5h8mGTAiOsSwi6t7Nsa9+h6PN+MrLoYqzwMZudPEI/29UvTKT0MGLh5
         mMg2D/UBL/+HlPtNnt2RQqmn4RBz3ILx/aWuWDYNInuU4TXblO1WGWMMjX+Vw6gkKBcL
         SVxSxKLn/F5Q0Dl8Veeg8uG9/Ila+J6BIY87G4AIWeuDg1wtCvlWnrXqNbp9AT3Pi2LZ
         Sjug==
X-Gm-Message-State: ACrzQf2DGfm27MRAQ4USnzdTObm1f04Os8QXDrMax3Nqhk9TsmxwkBhJ
        Y2AlVLImA0vX5Qb6UyHJSqrW4A==
X-Google-Smtp-Source: AMsMyM4F8pwBG2ol4uIyQcqXV5c8TBOZEqt60zBIx75B3u9J/VPNn+zDNr57dqlH8oGfsym0oeITeg==
X-Received: by 2002:a63:e507:0:b0:42c:65d3:f3b6 with SMTP id r7-20020a63e507000000b0042c65d3f3b6mr14301173pgh.395.1664691512791;
        Sat, 01 Oct 2022 23:18:32 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.45.132.124])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090a4bc100b00202aa2b5295sm6276242pjl.36.2022.10.01.23.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 23:18:32 -0700 (PDT)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH 0/2] pwm: pxa: Fixes for enable/disable transitions
Date:   Sat,  1 Oct 2022 23:15:50 -0700
Message-Id: <20221002061552.45479-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

I ran into a couple of problems while getting this driver working on the
PXA168. It wouldn't always activate properly when I turned it on, and it
wouldn't always deactivate properly when I turned it off. These patches
fix issues with the clock enable/disable transitions.

With these patches applied, the driver works flawlessly with my use
cases on the PXA168. I don't have any other PXAxxx devices to test with.

Doug Brown (2):
  pwm: pxa: Enable clock before applying config
  pwm: pxa: Set duty cycle to 0 before disabling

 drivers/pwm/pwm-pxa.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

-- 
2.34.1

