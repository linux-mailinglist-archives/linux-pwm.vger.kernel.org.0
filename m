Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BF718F1B2
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 10:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCWJYn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 05:24:43 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:37246 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgCWJYn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 05:24:43 -0400
Received: by mail-pl1-f170.google.com with SMTP id x1so1662029plm.4
        for <linux-pwm@vger.kernel.org>; Mon, 23 Mar 2020 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bdTHn3nXQn2EfuwJRXtyjGGloibRrt8s6wxTkj/U+A=;
        b=bXay2jdTdHaTyCEl44b+RKKSYect2Ugntrm1gnY07gcLAJusH9cN2GgkpbbAJdKd8i
         yRjbl+Q+1td9SpYJfXsilb0rCN4NqGqMZQ858xJUkEU3gq1dTOztsn6pSHB/F+fDC1Kp
         8UUgSzinRltm+e4NTfpjI9x2LZhCXqprz5rJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bdTHn3nXQn2EfuwJRXtyjGGloibRrt8s6wxTkj/U+A=;
        b=HJFOdRXPTxxZeWqP74q6gQFmFMJ4vzwTCnC+7fH2dd/jdCYbEBMFIzS68QlUMxfb+L
         HQdbVheTXBYUN3oDkGexONkftWQ2G1ZIzwy6lbV3qZ0+WvgFwxm6MqJjjnuxeujgm0xG
         SEAQ/2DA/tHNYq0AMYZRtdOvvrJtLKSMN0og0bmdYa6NiD60vxKiSXanp4I2TTaCF2Y3
         com4qmX2DJpJy0zWwHPr7s/coRUKH//5+Lf8P6DucPTsPHX9LKCZm87u9RAttu1wiGdY
         Azn04uXvFpeCEG3+B390ogRmCexnpCEldQ5AokE9Dl/hPxVZ2VvRa/kOO9NiHK92/yOq
         Pnrw==
X-Gm-Message-State: ANhLgQ1YqWLRzIv2eJ1YWanOM2i9ZAL+OOluzL1rA6KzLWmScH/zC6Ga
        AhZCr1fJaZmRLr+aoGRXKhcUaA==
X-Google-Smtp-Source: ADFU+vs4WZxYQEwx+zNTHgg6ZUe1A1BpGJdICQls2V2lfHdhLmgMWfyrbNZmAfQSvcLz5E9ekx460g==
X-Received: by 2002:a17:902:ed03:: with SMTP id b3mr1634171pld.247.1584955482641;
        Mon, 23 Mar 2020 02:24:42 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t186sm1093068pgd.43.2020.03.23.02.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 02:24:41 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 0/2] Handle return value and remove unnecessary check
Date:   Mon, 23 Mar 2020 14:54:22 +0530
Message-Id: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series contains following changes,
1. Handle clk_get_rate() return
2. remove unnecessary check of 'duty'

Changes from v1:
-Address code review comments from Uwe Kleine-König,
 added more details to commit message 

Rayagonda Kokatanur (2):
  pwm: bcm-iproc: handle clk_get_rate() return
  pwm: bcm-iproc: remove unnecessary check of 'duty'

 drivers/pwm/pwm-bcm-iproc.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

-- 
2.17.1

