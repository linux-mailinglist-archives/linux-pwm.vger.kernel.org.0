Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0519C41
	for <lists+linux-pwm@lfdr.de>; Fri, 10 May 2019 13:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfEJLMI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 May 2019 07:12:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50854 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfEJLMI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 May 2019 07:12:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so1630904wme.0;
        Fri, 10 May 2019 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SeeomiHNlKqT61ZnCxCoNTFspX7IJsPcDgZDfyZvFBA=;
        b=JIHQjxRn+9nwwJdnI1LjgveBv5oIFmblATnPFY3Z+pUsDisWuFOe3DzJSS5wQ/LXTd
         4kv5HsrCvY6ebo64nOJpGuPyplFd8+U1Se34Yd4aK4MqeVOJTYghRAEvgXoY4ZZ6+Ioo
         YkrXRNAFr+gbLB/0Px5PxC/R3fRlkmR9kMcYPin0/e62l5YqCgnR8aaVOALfvPUcdj5C
         AbVNHuAUJmjfsoURim6MpeHfrj4Wky/UE54KH2nP/dHd1USbjpbUxtIPmfa4JR0Duyp1
         RFT4zZw+jmaYtZ+dshO6+Il1eFZ/lug++JNj+BlA2eRK8ZqD6O3j+7oqICKkvJR2xr0N
         ysmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SeeomiHNlKqT61ZnCxCoNTFspX7IJsPcDgZDfyZvFBA=;
        b=Af8vzjjXWTI4toZYEM1y1RxsB0o5omPy1hN9IAPhcxx7hfpbvkKoSclVZ7aPXd6KQs
         1vPXuSbl86ZGk9iYyonpxZrIIj7qTbB6g6YNwxYts4EivEsRS0gmi/lPGr4MwRZDEg+N
         rlrlsVcN/YQo1KWhl7jWqboAQXvlpyzDFiE/qaaS29d1/oQsijuH0MbWwZjlbafG0KAn
         6bkPvtMQsxeDftLMFsbI0u6hyFYeC4EC9T5Ea3DIX474HK5FyXLg/N+X5dJR3KimHlqA
         rJxHg0gJLE6C1oeXC8cjXJ6V43HFlRAWeW4Cv3rrtDM5T/hknYY6iiXkueJ1du5iAj0W
         WO0A==
X-Gm-Message-State: APjAAAW2lkgg8tUUNN4hBL1So0+F/IYKVn2GFaSLbrovxFPM8wfPoLe4
        Nzwg3a2L+Phw9yFYqah8R6wnfp4AUlM=
X-Google-Smtp-Source: APXvYqwRsRtQFRwZ3PeNx9273KrGELQrQfuUOOZAwYSNK+hPC46PjeFWBQAcJRnSZlWCdGJ+uy0wiw==
X-Received: by 2002:a1c:c004:: with SMTP id q4mr6181336wmf.131.1557486726141;
        Fri, 10 May 2019 04:12:06 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y7sm14514541wrg.45.2019.05.10.04.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 04:12:05 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.2-rc1
Date:   Fri, 10 May 2019 13:12:03 +0200
Message-Id: <20190510111203.14436-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.2-rc1

for you to fetch changes up to f41efceb46e697a750e93c19e4579dc50697effe:

  pwm: meson: Add clock source configuration for Meson G12A (2019-05-09 17:29:31 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.2-rc1

Nothing out of the ordinary this cycle. The bulk of this is a collection
of fixes for existing drivers and some cleanups. There's one new driver
for i.MX SoCs and addition of support for some new variants to existing
drivers.

----------------------------------------------------------------
Anson Huang (3):
      pwm: imx27: Use devm_platform_ioremap_resource() to simplify code
      dt-bindings: pwm: Add i.MX TPM PWM binding
      pwm: Add i.MX TPM PWM driver support

Bichao Zheng (1):
      pwm: meson: Don't disable PWM when setting duty repeatedly

Christoph Vogtländer (1):
      pwm: tiehrpwm: Update shadow register for disabling PWMs

Martin Blumenstingl (2):
      pwm: meson: Consider 128 a valid pre-divider
      pwm: meson: Use the spin-lock only to protect register modifications

Nathan Chancellor (1):
      pwm: img: Turn final 'else if' into 'else' in img_pwm_config

Neil Armstrong (2):
      dt-bindings: pwm: Update bindings for the Meson G12A Family
      pwm: meson: Add clock source configuration for Meson G12A

Phong Hoang (1):
      pwm: Fix deadlock warning when removing PWM device

Uwe Kleine-König (3):
      pwm: sysfs: fix typo "its" -> "it's"
      pwm: Clear chip_data in pwm_put()
      pwm: samsung: Don't uses devm_*() functions in ->request()

Vignesh Raghavendra (2):
      dt-bindings: pwm: tiehrpwm: Add TI AM654 SoC specific compatible
      pwm: tiehrpwm: Enable compilation for ARCH_K3

 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        |  22 +
 .../devicetree/bindings/pwm/pwm-meson.txt          |   3 +
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |   1 +
 drivers/pwm/Kconfig                                |  16 +-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  11 +-
 drivers/pwm/pwm-berlin.c                           |   1 -
 drivers/pwm/pwm-img.c                              |   2 +-
 drivers/pwm/pwm-imx-tpm.c                          | 449 +++++++++++++++++++++
 drivers/pwm/pwm-imx27.c                            |   4 +-
 drivers/pwm/pwm-meson.c                            |  64 ++-
 drivers/pwm/pwm-pca9685.c                          |   1 -
 drivers/pwm/pwm-samsung.c                          |   5 +-
 drivers/pwm/pwm-tiehrpwm.c                         |   2 +
 drivers/pwm/sysfs.c                                |  16 +-
 include/linux/pwm.h                                |   5 -
 16 files changed, 552 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
 create mode 100644 drivers/pwm/pwm-imx-tpm.c
