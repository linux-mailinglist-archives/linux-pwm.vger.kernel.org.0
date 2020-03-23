Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26EBC18EFF6
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 07:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCWGxe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 02:53:34 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39386 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgCWGxe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 02:53:34 -0400
Received: by mail-wr1-f54.google.com with SMTP id p10so3072421wrt.6
        for <linux-pwm@vger.kernel.org>; Sun, 22 Mar 2020 23:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wGDd6myf+GdHCozxtrhmVLjHaTI84rSVkvwPMbf2b58=;
        b=cvOyUgm3MfUe3yvKUo5aJ1XPsi8hi07U2PZdZJHUC+l7JhpHg/ZEBxJ+h1nY84FsqI
         Di2wMDfKuZbHvQcV6aOX/CIP+n+BcgERrqB2X3Nu4/8JcPE4c8ZmvmaSEw2C44p66rF8
         O7kcYXct7EuBmdOGVfdzqc7lOAISg7+5BQLs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wGDd6myf+GdHCozxtrhmVLjHaTI84rSVkvwPMbf2b58=;
        b=HcxwipOROk3EPMb07DmMtLV4cA1MoSXAzW0eIZ0Z59yYjlpennEC9G8EZTJB55X97v
         gd9dEupONsEJpCxBTjsEQDFsN176DFuWD5SZ20Fiw97csQstZj3yTi20k3XCVynMOo9+
         UbUHhDJna61RR3uvplSPu+dN4zFMi743M3CD1hciBKkYhg0fDD18q/NLHD6kh6UfwLUt
         lqAu0CZnRhiqQDDzg0ARf81Cs2TfGB+udoQBTMoR3GCrWryKyzcVtIV4vb4e/5V/mWL6
         P85aB+/RAWat6Nro7Tppa1aW7/Hf7gfV/Ilp+40fflpFcVuuHCbsubre1djQ0uKCwyhb
         n5kQ==
X-Gm-Message-State: ANhLgQ2WHrzfd3G+9SZ+++ZHDsabPVCXEQmfDMa1HJ9qdXPGZ0X3eNT3
        TNl0Jxjd9txwDqjoAd4UcAGpPQ==
X-Google-Smtp-Source: ADFU+vvwB0MywmLuH1Zm77A5oLo0Gs8q6wjwWuZhQExQclt1yA8E1xmrBOZA/+OlJRl7ZFtCTqdUtA==
X-Received: by 2002:a5d:6245:: with SMTP id m5mr28064980wrv.154.1584946411935;
        Sun, 22 Mar 2020 23:53:31 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g128sm21127453wmf.27.2020.03.22.23.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 23:53:31 -0700 (PDT)
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
Subject: [PATCH v1 0/2] Handle return value and remove unnecessary check
Date:   Mon, 23 Mar 2020 12:23:16 +0530
Message-Id: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series contains following changes,
1. Handle clk_get_rate() return
2. remove unnecessary check of 'duty'

Rayagonda Kokatanur (2):
  pwm: bcm-iproc: handle clk_get_rate() return
  pwm: bcm-iproc: remove unnecessary check of 'duty'

 drivers/pwm/pwm-bcm-iproc.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

-- 
2.17.1

