Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA6544C71
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2019 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfFMTne (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Jun 2019 15:43:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45296 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfFMTnd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jun 2019 15:43:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so897618pfq.12
        for <linux-pwm@vger.kernel.org>; Thu, 13 Jun 2019 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYPkZ1kHlegoet40jMp9lNjbYY87zm41fO5/bnIRtVY=;
        b=FE4dJnLkWT/wzZIKxQnGm9hn3MWtcyqW/MT2wtn2Lwp9cOyu42ILOuYP/pEZisNPzJ
         arWgE8Ibze4Nb38GlZev9QW5KIPYAqK71cPwZGLO95/fclJ3exbgai9UrDk+z1owjH5m
         oEzN4hVjAhOfbGDr0fVqTnrlE/qoPBYiECaho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYPkZ1kHlegoet40jMp9lNjbYY87zm41fO5/bnIRtVY=;
        b=W9g9LdsvTW8eBtl/Z8vaTCLMvZ1oezBEyTvjy0FgHMqfdITBXsPx6OunO8Ae161kMM
         nV18Mvaj5NKQ16G17w8b1wfsnVbDB1spRad2+Od65xyUPtrf8xN7VSx6mYAeGLrAc1c7
         4fIlyMEdKPd1Nvq0ceQmlyAcPww4W+o5AAnqePiC/7Poo0VP8L55n2zRAqs+Pb2nSwc6
         O01C/rFnRD0uCY3SbWo8T94f6ZOfTeAxhQSDF9kfnnDe8JQ6DEIVe1JZJPwXzJSV5TjZ
         3eUF9t+bdEKu7H2vChmNg/Pq+OeW/hVysp20eIA6HR/gSBrEi+tXeco3QPUAb0dF5jRa
         Qo8g==
X-Gm-Message-State: APjAAAVOOXAeVbkuOcmY9MpCgbfpPeAXEFSoyYL5P8PLIzomdQf7SYY+
        JApeTiwZQO0IkRhP9Kilwm7B6Q==
X-Google-Smtp-Source: APXvYqycbVZXlvuqRzFiBln7zYVKC7ylbynb1qlibWK1KEuqMaOj0glQOfDd2xEXmxZcdeBGNd5Pvw==
X-Received: by 2002:a63:4c:: with SMTP id 73mr30610167pga.134.1560455012940;
        Thu, 13 Jun 2019 12:43:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v23sm7853735pju.3.2019.06.13.12.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 12:43:32 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/4] MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
Date:   Thu, 13 Jun 2019 12:43:23 -0700
Message-Id: <20190613194326.180889-2-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190613194326.180889-1-mka@chromium.org>
References: <20190613194326.180889-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add an entry for the stable backlight sysfs ABI to the MAINTAINERS
file.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..d51e74340870 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2857,6 +2857,7 @@ F:	drivers/video/backlight/
 F:	include/linux/backlight.h
 F:	include/linux/pwm_backlight.h
 F:	Documentation/devicetree/bindings/leds/backlight
+F:	Documentation/ABI/stable/sysfs-class-backlight
 
 BATMAN ADVANCED
 M:	Marek Lindner <mareklindner@neomailbox.ch>
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

