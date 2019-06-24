Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C64E51C53
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2019 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfFXUbX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 16:31:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40570 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731785AbfFXUbW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 16:31:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so7700933pgj.7
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jun 2019 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JP95lZdX+e5+GJVUv6OxKodaA7GTVH/s6o/zZ4o6Yqk=;
        b=GH6GaNaGuD+3/lq/E8qiZgIhrqY4POMDMF6xHbas+S9+1gjPhAdu+raSlGPuBLqD9g
         BkKsc+XCH1g3Z10BQaTguBLuGNZWvrF/v7D7o9CGRm3XNhjIs+7yeIKYYcTpDmT9I9R8
         CIvyVtU+X72CfuHwtLu5CTf7kBuk4/yEwY9wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JP95lZdX+e5+GJVUv6OxKodaA7GTVH/s6o/zZ4o6Yqk=;
        b=oYJNS42/K8hyNuQxZVFjA7HyT21Zybqg/hqqVer61Wk3V7vnWvkzS2ItoWZLDDmoZF
         9XhtyWgTNVc/Fde/D0buRqT8Yy+I3oq+EWI8LWPh+FwtSsghERhBmgYcfp0qD65z4FKC
         tMjBkbw5VQXHcZVTgob2bExAeUhB2aqg8WduPTKM3ZlarN3g0pLikJnE9pOHZEHcHgdD
         F2nJnfr/JLp4PMGn0kunv6IQl9w+lLLBL+OQvQpfs3MYxKCzqy3L+XAhlgxbHagQQpAD
         bX4jrE5/WW7bQf81yar/3JIi9Ala/5Fzub+txXYobxPzCyc7WlashNktw1TvgNsB1cVa
         jVKA==
X-Gm-Message-State: APjAAAVlJssnlL2uen9M9QKtaTVv12+JmCkpIgU+Z61y0KQiDF0J4brU
        PE5GEn/hiJjHsNbFc7YCiD8iZQ==
X-Google-Smtp-Source: APXvYqw9jBap6wGYgRpzAJeJ6bDMEgATfqj/PCB+aRPwnHh0ax4ayLJ9RddKSYOnMpDP5vtjzzt8pg==
X-Received: by 2002:a17:90a:cd04:: with SMTP id d4mr27797860pju.128.1561408281769;
        Mon, 24 Jun 2019 13:31:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r198sm6217026pfc.149.2019.06.24.13.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:31:21 -0700 (PDT)
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
Subject: [PATCH v2 1/4] MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
Date:   Mon, 24 Jun 2019 13:31:10 -0700
Message-Id: <20190624203114.93277-2-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190624203114.93277-1-mka@chromium.org>
References: <20190624203114.93277-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add an entry for the stable backlight sysfs ABI to the MAINTAINERS
file.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v2:
- added Daniel's 'Acked-by' tag
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
2.22.0.410.gd8fdbe21b5-goog

