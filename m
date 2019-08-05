Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9707281A14
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Aug 2019 14:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfHEM6x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Aug 2019 08:58:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44600 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbfHEM6x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Aug 2019 08:58:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so84311987wrf.11
        for <linux-pwm@vger.kernel.org>; Mon, 05 Aug 2019 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1BgNM2O50qMEacQ9ueo5XhVsMsgr663mURR/65nCS8=;
        b=x6ZSwOQbFU227kVmjbkUTbeCX9UkSrwO9Y8Znms5YvqO/c1EY25vYimVjwyKE5XMlj
         xJMPeL++r0FG3YpFbrCEe+ky0RgbyXi55r9HvWZJkPtDGGM5+soXNUqG+O6o+sP7aYfD
         212hWYsFrNbVLrGizdS5xi34j6WrVYVVFaZaZTqpO0hBgtuhzWNwvFwCOlllAmx5vL4q
         wVpuUveOgy8ouv555qscQY3uQEvTQtI7w6WJW5adzrJgmRnHwX96QTKEfN6Czmayd6ib
         pEL2h1ow0J8ZumiZ2bDybnyRVgaucZQ2U13go7woATDuA1K7P+UmMSjsMvmGd5jI7RD4
         ldaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1BgNM2O50qMEacQ9ueo5XhVsMsgr663mURR/65nCS8=;
        b=DCqZNh1rSk9fs6i1SaPefpSo5Onrt4qhGV18RJiDFzV2fcbP8g3dfqVpiTu5Wze47S
         zjJthIEU2BZlQZR0Xb3ezauUZI74djU8WcJE3lHf/gOSjv2ulfideIIWu9jrJ2OP0ex9
         VCg5zm1LeX8FRWIGOckLDNLfXDUKUZMl28Y4BeCtFwNpWF/wIJhpVxWf9yQb3oDKG0Pt
         andv+TUKwOKZhICymS/3ipzDkbA3uAN3uXMYWH8Yu56wc25Ndn3R0GfEjKNH8e3NWnNr
         Kkimy8myUAUcR5GYkLnl5SqQ5WkH/vbAAeVzEUplcj4rzcdYl6IJnzeodbEOjDs83UvZ
         F7sw==
X-Gm-Message-State: APjAAAUuVAjDVMiQ/D9b/8W0RnDacHE+dVxvjj1U5BV+4VAgqGIncXMh
        FeLJx+zN52Q5fQ83uXXjDZA4ig==
X-Google-Smtp-Source: APXvYqxjUyHGwnsENRGPnY7OdGXXY3X3GMtZZhvQF/96Pw7p0vEa9V6iBlA2Mnw7rhqJaFvPqAiD3g==
X-Received: by 2002:adf:c003:: with SMTP id z3mr79675952wre.243.1565009931515;
        Mon, 05 Aug 2019 05:58:51 -0700 (PDT)
Received: from radium.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k9sm15582779wrd.46.2019.08.05.05.58.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:58:50 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: pwm: pwm-mediatek: Add documentation for MT8516
Date:   Mon,  5 Aug 2019 14:58:47 +0200
Message-Id: <20190805125848.15751-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add the device-tree documentation for the PWM IP on the MediaTek
MT8516 SoCs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 991728cb46cb..9152bf5afe56 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -6,6 +6,7 @@ Required properties:
    - "mediatek,mt7622-pwm": found on mt7622 SoC.
    - "mediatek,mt7623-pwm": found on mt7623 SoC.
    - "mediatek,mt7628-pwm": found on mt7628 SoC.
+   - "mediatek,mt8516-pwm": found on mt8516 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
    the cell format.
-- 
2.23.0.rc1

