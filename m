Return-Path: <linux-pwm+bounces-7756-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ED8CA6CD1
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Dec 2025 10:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA72930361D8
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Dec 2025 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02687315794;
	Fri,  5 Dec 2025 09:04:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E12309EFA;
	Fri,  5 Dec 2025 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925487; cv=none; b=SUOlkA1FNZ6i+cEmHGTogFQzynOBVEJjxn0bpFWp4Kx3q5fhf1q8rT9eZi3sen0LJdcodZEaVQA/Kwt2RNgjtIZk/Tatwlv8lTkRaRtZLvD8jzpzMejjvZxuWr3IecCGuqDVNhcubo0Jjioh5hhtxuTwXIrW8vcEQ2jFmLAa7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925487; c=relaxed/simple;
	bh=oE8GoZP04K680ASQk1ozGiSx1k2fBPmgcNZwSMjytWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o6oRQTaKBt1aqaY3kz8zdysUWfzbjj6xmk74R7Il7MtXX3s3R51lSK1+7CkOdh/mGN2V0sLRwZctBpni3kBrS5q2RhvEABBXuRYljP9r4x9J1Bxl41mZzs9gbzGUaoAwonoNM0oRiWFEyUtw2KMvb/i1t51Kb7b99kisHzCoupI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgCXkGgOoDJpadmBAA--.39523S2;
	Fri, 05 Dec 2025 17:04:15 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	xuxiang@eswincomputing.com,
	wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH 0/2] Add driver support for ESWIN EIC7700 PWM controller
Date: Fri,  5 Dec 2025 17:04:11 +0800
Message-Id: <20251205090411.1388-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgCXkGgOoDJpadmBAA--.39523S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF4UGFyDXFy7Cw1fJr1xAFb_yoWDGFbEkw
	4furZ7Xw4ruF95AayYyrZ3ZFyqyF45Wr1vkFZ0k34Y9wnrur15KrykZ34UZ3WIyF45AF1D
	AryIyF1Skr17XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbhxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbknY7UUUUU==
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

Add support for the ESWIN EIC7700 PWM (Pulse Width Modulation) based on
Synopsys DWC PWM.

Features:
The EIC7700 PWM driver supports a duty cycle range from 0% to 100%, with
explicit support added for both 0% and 100% duty cycles.

Supported chips:
ESWIN EIC7700 series SoC.

Test:
Tested this patch on the Sifive HiFive Premier P550 (which used the EIC7700
SoC).

Xuyang Dong (2):
  dt-bindings: pwm: eswin: Add EIC7700 pwm controller
  pwm: eswin: Add EIC7700 pwm driver

 .../bindings/pwm/eswin,eic7700-pwm.yaml       |  73 ++++++
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-dwc-core.c                    |  76 ++++--
 drivers/pwm/pwm-dwc-eic7700.c                 | 231 ++++++++++++++++++
 drivers/pwm/pwm-dwc.h                         |  16 +-
 6 files changed, 384 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/eswin,eic7700-pwm.yaml
 create mode 100644 drivers/pwm/pwm-dwc-eic7700.c

--
2.34.1


