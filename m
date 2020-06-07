Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608191F0DF6
	for <lists+linux-pwm@lfdr.de>; Sun,  7 Jun 2020 20:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgFGSZ3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 7 Jun 2020 14:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgFGSZ3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 7 Jun 2020 14:25:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314E9C061A0E;
        Sun,  7 Jun 2020 11:25:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l11so15024458wru.0;
        Sun, 07 Jun 2020 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L25w3o1GNwNdRaVpC9oNp2Mtm+R/BbGezD4tjX+UBmA=;
        b=FJTtoAIW4Z/3jLEB3vSkuzC70s7dB6zJVDdVIuRJUBJLX3HW+GCwu2sAYYxAfgDH+z
         hoLNeJYeFBkxa+Ln2/kTj3WUEGMAhnReqdSkcrs9lfnSAgrnOlTnNYgzRXePGNJEnRa5
         jnjU43+AhZlKwTwWhxp+GYPhOrYmT5t7j+fEzVrPFXXtQumh7Su8xN9PtKJmbFrsvpiL
         LyYqusgtaQuaRcCfgl6VGyM56qokIOlHv9brjcbgnJbaGYbzyXFmynUCxFTQm57kVoM2
         obTFsxuXc3q1OBtXqL7BrbCQG8G4zKttlporGCQUDLCUh8178RHp75iYKZFQjLYYXfie
         /DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L25w3o1GNwNdRaVpC9oNp2Mtm+R/BbGezD4tjX+UBmA=;
        b=lT/5/eQT/EHjxgPz1kiQrfITdb8LJW24px38VqSLTPKrHepdXjMl4vAkT4c/9nYmOb
         PBYKQZJozC+FOK+MeCH5zgoCMWrycHfotpyzBcpj1ipdxZAhy4Z54bMVD9UUjqSYaqWE
         WXf2zdr/ZlUY2gctuGkwhe164tonDJERHlV3KzV+wV7wDIvHoR0EZ3dfpWjnXB03dNCu
         Y04VswXAZGvfN5Zye6N4XubezwX3HqRuhufhfdEUFWx7hCn1oGZRX7vlJWQLQXFnpF/z
         Lsr213heolC2YKaKek3IZ3Jtq8xvTZ4UvmOfGGMp2Y4Popm4RwuuN4m1mzlulp7i6c4D
         HlHQ==
X-Gm-Message-State: AOAM5304diVuoMNliw2gJrBCDlNnRI57TBIdqEaEEXqrXrfyKOTFH5Zz
        lL+9xOJo26oie7Rehfl0AJQ=
X-Google-Smtp-Source: ABdhPJx7KEJIypls5310HgMD7v/PkqpvOKWKMA0hvivTaaJ0kXPjcLsZ0KQDjZvolNArgwDgqYNHPA==
X-Received: by 2002:adf:93a3:: with SMTP id 32mr19780844wrp.344.1591554327287;
        Sun, 07 Jun 2020 11:25:27 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id h18sm20434981wru.7.2020.06.07.11.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:25:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 0/2] hwmon: Add SFR NeufBox 6 hwmon support
Date:   Sun,  7 Jun 2020 20:25:22 +0200
Message-Id: <20200607182524.3221837-1-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SFR NeufBox 6 is equipped with an I2C connected chip to monitor voltage,
temperature and other stats. It also has PWM LEDs that can be manually
controlled or set to specific hardware monitoring modes.

Álvaro Fernández Rojas (2):
  dt-bindings: hwmon: Add SFR NB6 sensor binding
  hwmon: Add SFR NB6 sensor driver

 .../bindings/hwmon/sfr,neufbox6.yaml          |  96 ++++
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/nb6-hwmon.c                     | 466 ++++++++++++++++++
 4 files changed, 574 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sfr,neufbox6.yaml
 create mode 100644 drivers/hwmon/nb6-hwmon.c

-- 
2.26.2

