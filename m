Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F963D85BE
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 04:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfJPCLo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Oct 2019 22:11:44 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:28028 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730641AbfJPCLo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Oct 2019 22:11:44 -0400
IronPort-SDR: Y2hM1k2LM+35/q3tQs5e8xAqSwb4dPmqwT2h36Qx4vb5SoWbAkQDQqlvnmrMA6CTr33k7+bHbV
 TXyfDHA/BXnKFRzfUGV6E6q1m5MwvPOeVSHN/KNFTqnlgmJwJQ9qIfBR/K6ahEcEBiv2eoU/LS
 U2aOygo/fdf7g8sK8f0Q7YXEM5vMX40zSl+uySlm0/aR4U+8fJbqxTezCq+pXB5+xYOUYsCLla
 5baHEnDNt8tt4vhPQ9cLNsZ8oClk9jEWHpkqOJzvtJ5mhQvZE63dxM9nqebxu11QNaDbPXhtJX
 acs=
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Oct 2019 19:11:44 -0700
IronPort-SDR: +kd7zoLPzaU5Z2007CGlmUldWh95+f21ofM5HaduClRMpYialBlD6jIm58EiCl6jj6xY9xiEPs
 IGLYMw9BliT1e/9CGlPblTPK01CKEOZyXqv2C+R5lhojsnJq5r19+GW1cz4WrTZR1PEmb84od2
 rpkzAE4vIkVAwxdxh9XzXcZyE/aPmc9jdLQc8+WOi6Qhe1eB1vvXXiQPc/fCIs0HiqouLtRyaG
 ufi4uFdRtWuuv6B6PlcasNLNHOmCEOEcBFUtDNQUgLSUIQa8vGx/QQZeK+TC515z8TRNADFJQ/
 Nty14On+nYP2q4Iv5oQXTbSQ
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg04-sd.qualcomm.com with ESMTP; 15 Oct 2019 19:11:43 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id B450A473B; Tue, 15 Oct 2019 19:11:43 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH 0/1] Convert period and duty cycle to u64
Date:   Tue, 15 Oct 2019 19:11:38 -0700
Message-Id: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Reworked the change pushed upstream earlier [1] so as to not add an extension
to an obsolete API. With this change, pwm_ops->apply() can be used to set
pwm_state parameters as usual.

[1] https://lore.kernel.org/lkml/20190916140048.GB7488@ulmo/

Guru Das Srinagesh (1):
  pwm: Convert period and duty cycle to u64

 drivers/pwm/core.c  |  4 ++--
 drivers/pwm/sysfs.c | 10 +++++-----
 include/linux/pwm.h | 16 ++++++++--------
 3 files changed, 15 insertions(+), 15 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

