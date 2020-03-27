Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE251952C8
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2020 09:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgC0I1w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Mar 2020 04:27:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42623 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgC0I1v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Mar 2020 04:27:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so10304702wrx.9
        for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2020 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CkVRhFLjR5BXVsdWkkY22kPoQIG0Zdn2VQ6NVgBKV48=;
        b=cuGfgicMqDk4qiU3ysMlg91HLCLPOZbXo7igRicRO6QTzqKuyqlrU0cCPo+ied8CsK
         jx6W2/vtAg0MPFaSohSUfQSDAzmxlQbsdkmGCODjzJYjHyJmJk/Ju0PybMfzHT70P9qJ
         avqzT8aW3bvc16hZcGU595c4zsD62d4T1I+BuSEeXzcuYBUbqnK480CnSxWw57BRaYN/
         WiZiY67zl2oxF+5G/zgqk78pl2rKxqJDTb+XcNBG1dzIFwDpgpNunnyNaDG1P5atDXf8
         /LOYjlkda4K3R9f/VS5TB9Up2Wdq+WxQUbCPLRxwQNXv4yzmOO5OGZ+u4XmiJ7mHLHYm
         B4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CkVRhFLjR5BXVsdWkkY22kPoQIG0Zdn2VQ6NVgBKV48=;
        b=XoGFXW63cW+T5/jRZA541x9b0i/r/jrPZ/Eq1nbuuGZdWRf7siG0jEn0wBQPxrWOj7
         JCVKheMv+h0k85rY3jD7DFMnZTHcyc3C/54FtpKHE71ZDkJPWfM1c6j0dbldgkZbgBId
         WMGryUh9Hh4Qk2036A2L5Ze15cjFf+dIEWRW34ImGUmtuLVV2KSf1o6pU72yXPop8vuR
         FpeS6Bt+EL0jWPISmGTjzBqP2JkaH+VBSNCf6M0EVqfQwdoln+ySxG+5ozbTba7MyQIB
         TcMLJHgpIwWgv/xCvKCXpjhkbohpro4aurI4BS+MVG23woQs5A4w/9q2WIbvB9KDqlBl
         R6kQ==
X-Gm-Message-State: ANhLgQ2mVPoBysTzCs4Qmm0DvP+2C1S7sbBDvf3mTzt6uRQwNpC3C20F
        0a9Bjkoq0ZTYAwRdzl1ilgC6Sg==
X-Google-Smtp-Source: ADFU+vtCW1W+yt8zBsprd4LHiYYpC1yHMIMxUiv60XGYvGRFRU9BWgLV8s918txIquxn9g/Qf+pVdA==
X-Received: by 2002:adf:bc04:: with SMTP id s4mr13567000wrg.244.1585297670103;
        Fri, 27 Mar 2020 01:27:50 -0700 (PDT)
Received: from dell ([95.149.164.95])
        by smtp.gmail.com with ESMTPSA id 127sm7479123wmd.38.2020.03.27.01.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 01:27:49 -0700 (PDT)
Date:   Fri, 27 Mar 2020 08:28:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: [GIT PULL] Immutable branch between MFD, IIO and Input due for the
 v5.7 merge window
Message-ID: <20200327082840.GH603801@dell>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581895931-6056-1-git-send-email-jeff@labundy.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Enjoy!

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-input-v5.7

for you to fetch changes up to 189c3c495ad7382099a641664171d8b047d9e9b5:

  iio: position: Add support for Azoteq IQS624/625 angle sensors (2020-03-27 08:25:59 +0000)

----------------------------------------------------------------
Immutable branch between MFD, IIO and Input due for the v5.7 merge window

----------------------------------------------------------------
Jeff LaBundy (6):
      dt-bindings: Add bindings for Azoteq IQS620A/621/622/624/625
      mfd: Add support for Azoteq IQS620A/621/622/624/625
      input: keyboard: Add support for Azoteq IQS620A/621/622/624/625
      iio: temperature: Add support for Azoteq IQS620AT temperature sensor
      iio: light: Add support for Azoteq IQS621/622 ambient light sensors
      iio: position: Add support for Azoteq IQS624/625 angle sensors

 .../devicetree/bindings/input/iqs62x-keys.yaml     |  132 +++
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  |  179 ++++
 .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |   32 +
 drivers/iio/Kconfig                                |    1 +
 drivers/iio/Makefile                               |    1 +
 drivers/iio/light/Kconfig                          |   10 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/iqs621-als.c                     |  617 ++++++++++++
 drivers/iio/position/Kconfig                       |   19 +
 drivers/iio/position/Makefile                      |    7 +
 drivers/iio/position/iqs624-pos.c                  |  284 ++++++
 drivers/iio/temperature/Kconfig                    |   10 +
 drivers/iio/temperature/Makefile                   |    1 +
 drivers/iio/temperature/iqs620at-temp.c            |   97 ++
 drivers/input/keyboard/Kconfig                     |   10 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/iqs62x-keys.c               |  335 ++++++
 drivers/mfd/Kconfig                                |   13 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/iqs62x.c                               | 1063 ++++++++++++++++++++
 include/linux/mfd/iqs62x.h                         |  139 +++
 21 files changed, 2953 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
 create mode 100644 drivers/iio/light/iqs621-als.c
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c
 create mode 100644 drivers/iio/temperature/iqs620at-temp.c
 create mode 100644 drivers/input/keyboard/iqs62x-keys.c
 create mode 100644 drivers/mfd/iqs62x.c
 create mode 100644 include/linux/mfd/iqs62x.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
