Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5821EBBB8
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2020 14:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgFBMct (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 08:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMct (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 08:32:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C27C061A0E
        for <linux-pwm@vger.kernel.org>; Tue,  2 Jun 2020 05:32:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so12575690ejb.4
        for <linux-pwm@vger.kernel.org>; Tue, 02 Jun 2020 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/gohG8VROga52eXXldtR18TlxsJ725QrGCsrOle7ww=;
        b=bdBW18mWv8LfRIKKDeI/nHwdJWPbr7/AY/+vkQauu83OBMxCBFphdsponnGUI8N7TP
         u22JVBn+aROcZnSo9v0Rh1Urtlc3CvNYFGAhjyCc5x5uN20uhEHjGlVleQGgd6VFE5kJ
         L2bBEohf/K7fMGvwZdDGvmqUJ/aLlDWGDpj1P5ynXnh84BfhT/97V03sH1UMjNI4zvGF
         R37IoXrsW83ZJwiu+BbgwjAPz/KURG7RkjG5/QcAGP1NfF4+Qh+ihqcirHtT2xD7qrqF
         r8vwkbb0HvuyrunerOgsQ/69VzrhrXlxwgGHKEBBdxfVWruxgAqe+kpZ4/7uPD5d8IGs
         IvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/gohG8VROga52eXXldtR18TlxsJ725QrGCsrOle7ww=;
        b=gswf0zxXacC6uMshnfo8JN64x80kX9hlXbXeyBUv7amOeaJuEhV6DbWXz9NiUfNQy3
         uokY7qtwnJKTESKDwen1D5JLop7i/rOFZHifKGmv3uDe0kL/nTfVp5OHiB1cZBg+OinC
         zFeR/waxN+a1bl8bf2X0BDZ52gKFrU+MWREL9c67CVaEpazFlu3BTBh/XgwoNYa4BXup
         SgM7x6aKdIUegKkPAhCPXk2jbcKQT004s6VjVK1SfTogDchuNXV8o6W7O8Ik7E47uk9f
         fh+1HLOzsg0/dPUUVNqCjirpgU2Q2/3RvFUvfc2yhl601Lytp92Vg0PGVZUJu1GbpIX3
         E4Lg==
X-Gm-Message-State: AOAM532Wdr/z8uQeV8sJ8N+wZUEoeX21nuHjtcT9wskpqPQatX5lJVJl
        ul+kFhfrIihcivkNLWBLlUU=
X-Google-Smtp-Source: ABdhPJx3A8/5MF8Qp0+Ip73NulOevVgv5WatsZRYnaYEQmMXE3R3BQwX/jrgIQ5or8ddoZeZ4i+igg==
X-Received: by 2002:a17:906:cd03:: with SMTP id oz3mr24790660ejb.391.1591101167489;
        Tue, 02 Jun 2020 05:32:47 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id y26sm1486185edv.91.2020.06.02.05.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 05:32:46 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Lee Jones as reviewer for the PWM subsystem
Date:   Tue,  2 Jun 2020 14:32:41 +0200
Message-Id: <20200602123241.3363904-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Lee has kindly offered his help in sharing the patch review workload for
the PWM subsystem. If this works out well between Lee, Uwe and myself it
may be a good idea to maintain the subsystem as a group.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..b8889bed5d1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13736,6 +13736,7 @@ F:	drivers/media/rc/pwm-ir-tx.c
 PWM SUBSYSTEM
 M:	Thierry Reding <thierry.reding@gmail.com>
 R:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+M:	Lee Jones <lee.jones@linaro.org>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
-- 
2.24.1

