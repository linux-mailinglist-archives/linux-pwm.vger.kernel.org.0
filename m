Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579EE290BBB
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403917AbgJPSuV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 14:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403913AbgJPSuU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Oct 2020 14:50:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACB9C061755
        for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2020 11:50:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b8so4145612wrn.0
        for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2020 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/qt5rC8TcV9uWJA4Vg3L7tk7wdB1aonBorO6kFYPdy0=;
        b=gcnDSn4ZzO2qbERX22Nz2VEEQJVZZ5T08r149VQhNUsCk5FBniL3aSV/YzqTvZgcVS
         5WZCzZq8QZaXi+ggPmsi7YsQvmnTvfme+TaIvl1UO+YOfuIcrQ7O1R5nUfKOKiJzAC40
         lc1cdWwgMCd7d5nqUbOg8S3xGl7szKH3/rpMkseUy32P2uuMp2BV82yZ9KITzjChIWJ6
         bD9Lyc/DOcu2vWCVJ9ffvj8VLTaQ2S7TG8G2Awjz1I86J9ILtMfGhS4WXmft445ImYbE
         Akw+SNGajMcSqTAwUL68ApblRsPg77LgZURHkU4yedZ/4mX0z/dvscaRK19GKVqSLB4M
         KNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/qt5rC8TcV9uWJA4Vg3L7tk7wdB1aonBorO6kFYPdy0=;
        b=LGnE30DSivKTCVVl8/0aGk0E37kGE2EEjicnH7M/rKHoUQ2eyxVtVnWHA+k3V7OFvq
         xYsU9zOv9liRpqDYJW1/vjfpPderBAtCIIlSiGaMQkEgMU9DUk20RFye2RaAk0I7Bx6F
         Mwyvm0PiSfXYJ1FypUn62qquiDYViBox7TVMIaMx8ouciMluPZpVAKkLZJW4FjVyGAUj
         BSak5xIsoYJKsxCcNdsmAYC4gMYob61icJYrxHCMW2PTsnPhRtC/J6RXtaNQ20JfNjlv
         yN3cHVagSAn2IPX3FnZCiP5Nl02d0e0vK/T2C2uCdqJpwQEkkpnL3tntiR1TcicTbXEq
         ifHw==
X-Gm-Message-State: AOAM530nj3EXLl623yS27MI32V9/XePFIUs6c4KfjdAMZy6QgA0mL1Bo
        s0c88LW4HOnXdasFu+BgVr/69Q==
X-Google-Smtp-Source: ABdhPJy9rogRUbRH4dtXXmQz5trbR1XOCrzg+u3rkfEEELTlf8yrJElPm1RJB7hmwEdivrExNW+leA==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr5295283wrr.377.1602874219287;
        Fri, 16 Oct 2020 11:50:19 -0700 (PDT)
Received: from localhost.localdomain (211.163.185.81.rev.sfr.net. [81.185.163.211])
        by smtp.gmail.com with ESMTPSA id s1sm3727102wmh.22.2020.10.16.11.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:50:18 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH] dt-bindings: pwm: mtk-disp: add MT8167 SoC binding
Date:   Fri, 16 Oct 2020 20:50:15 +0200
Message-Id: <20201016185015.3371433-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add binding for MT8167 SoC. The IP is compatible with MT8173.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
index 0521957c253f..902b271891ae 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
@@ -4,6 +4,7 @@ Required properties:
  - compatible: should be "mediatek,<name>-disp-pwm":
    - "mediatek,mt2701-disp-pwm": found on mt2701 SoC.
    - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
+   - "mediatek,mt8167-disp-pwm", "mediatek,mt8173-disp-pwm": found on mt8167 SoC.
    - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
-- 
2.28.0

