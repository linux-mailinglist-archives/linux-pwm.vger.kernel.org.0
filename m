Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96CD39104
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2019 17:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfFGPoV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Jun 2019 11:44:21 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:48028 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbfFGPoU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Jun 2019 11:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559922256; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=nn6RIORPQvEj4MNZ9mPFLhw4J2PhKsLEWf+gGxpQV0I=;
        b=VQmtVJAJrh89fwCdB4/nVjLe9gVObowaj6Xkf0c5wFOOYBGIZtPfcnaIkwDrGjaRBzGBG7
        h+BHxB/Zsw0wrLNpBJE0ummHguYkMgK5ys/Ab3B6IijcYZYh6ZE5+PLMCyuRX6FsDc+0tx
        7zsaTTMe0O83PIQek6KTqJ/EEbrnpJQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] PWM JZ4740 fixes and cleanups
Date:   Fri,  7 Jun 2019 17:44:04 +0200
Message-Id: <20190607154410.10633-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

I rebased my patchset on top of v5.2-rc3 since it didn't apply anymore.
Patches 1-4 are unmodified. The old patch 5 added a SPDX license
notifier, but somebody else added it in -rc3 apparently, so I dropped
it. In the meantime I added two more cleanups.

Cheers
-Paul



