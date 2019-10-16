Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED54D89E9
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 09:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfJPHiq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 03:38:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42419 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfJPHiq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:38:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so26708854wrw.9
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iMXhyYMO456ZU0dReZjcFCoBu/k6fafNGbfZivdnNbU=;
        b=d5ta4ObLPrjLCaxINlBWjgTLEg2f38FPYVKUIRRN97v98ZV+EPW3ZwIUqOPfUpzegq
         Twm3vRDy3RDRZHres7RwE6qOr2tv0z8Fdxl8IsEmKl8Ev0LuthLTcvJ3zEfQlbHGI/Sp
         bf4D5n833aA8JZNuJnapL0n8oMmelumKVE3c06S128pstAgoIDfKnmmVE8v5ktOgOcOd
         ZI9MKt3TaJRPK/ktUMNWtoMMciY9lGviLJ5AW4e47MEUYAX07j76bl+HxmAiBhaXEE0E
         7b29axqE5g1oaAba/XcQXsWcJP/hk9Svr3T9hLjDrmmoSK1JC8GEv2/0LrsI13IRKJZL
         SJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iMXhyYMO456ZU0dReZjcFCoBu/k6fafNGbfZivdnNbU=;
        b=OjrxsfAtBGy0x+OdUe25N6r15WnSgOyRu9LMa99qEnGaoeyVAzI9qnYfOn58FZFUGf
         dWVZ3Eltz8Q/LkaJsX7CIELxDJY2wS75/eYF0sWvD2JnuwI9gtTvo3bvZhy0FNXtlWnQ
         Q2Y9WWbbVmYGdnjyyIdG2xtH1vY2u+VwEDGbBfEmtAofZz+y20u9JE6nU+ROqk565dL4
         cNeWEvXPNxmXS2+aqKc5B2sPg+T9WaI9eLYWOzHXf+6JhksZGLjdG3JenHNvzh5rRbOU
         0oqSnVHaHJX8Gp26oHHpv3Tm2H7cigVMsugnwo7dSTXhRQXWEtnmjF5vSjR0BtygH0GY
         lRdw==
X-Gm-Message-State: APjAAAU2irV58QGMmrVeS9Xo5wif/FP3rYvonb98vLCYp/CKXotk5kpc
        QOuI54ZO+5cBcQVnJuiW0Yg=
X-Google-Smtp-Source: APXvYqy9KzwtXUQ+ur3KFUmn5AW6xHmAzAAwfeopK/Au+e/J1dplyiO5xLVWc0cVhcmMpfDrxmk/dw==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr1417624wrv.177.1571211524648;
        Wed, 16 Oct 2019 00:38:44 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id r2sm3194788wma.1.2019.10.16.00.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:38:43 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH 0/3] pwm: stm32: Minor cleanups
Date:   Wed, 16 Oct 2019 09:38:39 +0200
Message-Id: <20191016073842.1300297-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Looking at Fabrice's STM32 patches I noticed that we're now passing the
breakinput values (u32) into a function via int parameters. The easiest
way to fix this inconsistency is by just passing a pointer to the break
input structure. There's some preparatory work here that makes the code
slightly more readable, in my opinion, but it's really marginal, so I'm
not terribly thrilled by this series in retrospect.

If nobody else thinks this is a big improvement I'll just scrap it.

Thierry

Thierry Reding (3):
  pwm: stm32: Remove clutter from ternary operator
  pwm: stm32: Remove confusing bitmask
  pwm: stm32: Pass breakinput instead of its values

 drivers/pwm/pwm-stm32.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
2.23.0

