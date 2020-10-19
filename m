Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336DB2928DA
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Oct 2020 16:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgJSOHL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Oct 2020 10:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgJSOHL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Oct 2020 10:07:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E259C0613D0
        for <linux-pwm@vger.kernel.org>; Mon, 19 Oct 2020 07:07:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so10451630wmf.0
        for <linux-pwm@vger.kernel.org>; Mon, 19 Oct 2020 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ebVSTF6C01uLAR4vrWlCZCg3/AjoCT6KW7MfS2FL1W8=;
        b=q58YBicn3ANSptSyrmNZgR7LtjM4s17qFl6avOnGe9XlPfwuz66SeedC071MO3YsGs
         QZuAKNHudNN1e3YDhOWn0R4TbddBnkUX1+W3zP4DG6b3gOlTVdoX0fYrFipNZKSGV14t
         TOByIynj6gsulAIXfRH1ceClLqOEV0oYRKMHg7wufNCcFoLvz+VbtrIzJb8zJBS3wGfd
         TtD/dEssRkie0FcIUx43DkEPJtjhuiO8FS2WTP3liPopHkfLRLUhsQFlBErDZ5Hr9qfw
         0/zRxt0k6BP1JWLJGAIp1TV2PqD0AVYAJLnsJqS9ZA6uo+gCBo93vSqV7D51WitWcpBc
         imhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ebVSTF6C01uLAR4vrWlCZCg3/AjoCT6KW7MfS2FL1W8=;
        b=OSUWJqwn1o2ydxncuu8dXQnBr4+7V2Q8d1yZdyVTeTooZPX9kFAlN67m60ApGFi7On
         9ImPDmsMR5zOou/iLlKtjIzwlkKP1KVlX0NgYtsMM3I2GaBrzJczj62bUtuQI7R0ye2o
         MokQMGu11KGeL6JJFBE9M4QI3W7rNyjWaa1I49c7JYHvJKxrObBq7pX7RPiOqvf57TUc
         N1vyO2GJ/UAyCtgxWiJAbnm+MUEXhK7V7hPmoU+tMHII7/UeoMczsJO4qAxrfVWgRyVS
         EShVhGefMPR5RQd5Ht6Xn8gunYJdcev6Y/CyaVgsvg4Qiq0X4X8RZNAzNRG6vSpJ9z84
         C5aQ==
X-Gm-Message-State: AOAM530ptQiPXEAm1GB3Naa+CQ8umvBlx6oJTdvSPUKh5SM32ldZce05
        azXDL2R1+LuMKu298vgz1YrM5Q==
X-Google-Smtp-Source: ABdhPJypMv0Z1XIG/QxhI7DDBx/5GK8UprJZ36/vq0bC5DYKq1zcI1ZC4PpBiCXyNPi+pp8z+Y6jEQ==
X-Received: by 2002:a05:600c:1081:: with SMTP id e1mr18704315wmd.156.1603116429676;
        Mon, 19 Oct 2020 07:07:09 -0700 (PDT)
Received: from localhost.localdomain (26.167.185.81.rev.sfr.net. [81.185.167.26])
        by smtp.gmail.com with ESMTPSA id a3sm114182wmb.46.2020.10.19.07.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:07:08 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 0/5] Add PWM support for MT8183 EVB
Date:   Mon, 19 Oct 2020 16:07:00 +0200
Message-Id: <20201019140705.1518822-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series adds PWM to MT8183 EVB. MT8183 has 4 PWM channels.

Fabien Parent (5):
  dt-bindings: pwm: pwm-mediatek: Add documentation for MT8183 SoC
  pwm: pwm-mediatek: always use bus clock
  pwm: pwm-mediatek: Add MT8183 SoC support
  arm64: dts: mediatek: mt8183: add pwm node
  arm64: dts: mediatek: mt8183-evb: add PWM support

 .../devicetree/bindings/pwm/pwm-mediatek.txt  |  1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   | 12 ++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 14 ++++++++++++++
 drivers/pwm/pwm-mediatek.c                    | 19 +++++++++++++++++++
 4 files changed, 46 insertions(+)

-- 
2.28.0

