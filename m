Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7883D879EF
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406777AbfHIMas (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 08:30:48 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55086 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfHIMas (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 08:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565353846; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=NkcjE2Ss73/mkw6rvsVapDMWPcizATzW5QqxPHx9NUc=;
        b=WDA/CMWGeGE7RYy00QcTLf0TFZ/u5oD5baRb6NEJokE+2xWSjRwnUK64vE2kjrx5C+8W/g
        gNdVy10Q3JmPfM0nYZV50LGRKuSv3yhrLM0fQ6k7MIdaUu9kD52wYXy4R5eV6qX1T3TFj+
        p/Njzo4OJT5vjUn/EF0SZzYBCeoFkUg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] pwm: jz4740: Driver update
Date:   Fri,  9 Aug 2019 14:30:24 +0200
Message-Id: <20190809123031.24219-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Patches 1-5 come from a bigger patchset that was cut in smaller
pieces for easier integration to mainline.
(The patchset was https://lkml.org/lkml/2019/3/27/1837)

These patches are the exact same as the ones found in the patchset
shown above, with the exception of patch [1/7] which now uses
device_node_to_regmap(). This function was added in a prior patch,
now merged in the MIPS tree.

For that reason this patchset is based on the ingenic-tcu-v5.4 branch of
the MIPS tree
(git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git).

Thanks,
-Paul


