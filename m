Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7C87BFA
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfHINsx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 09:48:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37474 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407117AbfHINsw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 09:48:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id w13so95108296eds.4;
        Fri, 09 Aug 2019 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yR+5s19H5XCk7doKkod5jfqUZgK48EnsW+tAB5UH8bw=;
        b=dAKPX25MR2kQZQZvgVKx5T7q/vyxdZRYsqbQOt+mcp3EMtuwhvqwBkUfQiyBRGsHqF
         JsGiM+VsbPyY4TLT88JdaiQgPm11MSsTwFypm09G/XbjHMtgAI8sEOSkJuP0dfzFZmb+
         QTU8CoazveBoQTaPgIKLAfSUPELNsMuxVuMsqVQ4CL6aZPr8AgA/NF0mCRaXe12bXCuO
         iEHhhbzoFQ8cjB58nQHrPW3J4o1kUDQDVayMIsJCgoM0O/R/mBRD87Da8CSzPk8uyeKo
         5wN+b6qjcwEnPz3ydmuo2uilF8fhh+r3aY4g1tZhc/fMO0tbTt4+3M1pBA6NUetzjNLG
         Hqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yR+5s19H5XCk7doKkod5jfqUZgK48EnsW+tAB5UH8bw=;
        b=QqA4xDf+6bVbvwLzTw/qIMdGCNTZFkEPKjVcNWvZiZ84uhflx2s9uQlTEZAiR5aqee
         hhBnIrGvgnJg97/8KLmVRCSVwcZ6xBCHcKiWHQkuT5e6yZ3eeoyZldAOSRFoNWyV3x0v
         vcer5aGy7tMRM/Hanq7CG1NwMH8zOEssYCtBqAFccw9dLxfZMNUe68ZcYaB8More4FaB
         SyKxBPR4V0XR/Mhh3UTCsLBxWy8szrLoW1NCtKUwPSAXCihK90oKZVd/x19M174b29Gi
         5IehTVbvStcYb1Z46zIm/0XbMYyoTu90faH0LZxgnXGlnlAOMcYH4IO5ADizdAb51878
         k02Q==
X-Gm-Message-State: APjAAAX2L0MznT+J5q64nJBc7m6MU95VeaaR+Hb7kf17mnwGoXDzS4XQ
        hMLSuBcvUz3I6USPZet+sn8=
X-Google-Smtp-Source: APXvYqx9OCKX+nWFkLmri91BqlVkrRygPvan6hB0ETflRbvT1wRyzTakPMOjjsr4Zd4n2oNcNVUNvQ==
X-Received: by 2002:a50:f5f5:: with SMTP id x50mr21466114edm.89.1565358530524;
        Fri, 09 Aug 2019 06:48:50 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id rv16sm15937818ejb.79.2019.08.09.06.48.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:48:49 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Fixes for v5.3-rc4
Date:   Fri,  9 Aug 2019 15:48:48 +0200
Message-Id: <20190809134848.18297-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.3-rc4

for you to fetch changes up to 6cf9481b440da6d6d86bd8e4c99a8b553b9d1271:

  pwm: Fallback to the static lookup-list when acpi_pwm_get fails (2019-08-08 13:17:38 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v5.3-rc4

This contains a single fix for a backlight brightness regression
introduced in v5.3-rc1.

----------------------------------------------------------------
Hans de Goede (1):
      pwm: Fallback to the static lookup-list when acpi_pwm_get fails

 drivers/pwm/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
