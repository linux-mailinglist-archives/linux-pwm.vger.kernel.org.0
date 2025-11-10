Return-Path: <linux-pwm+bounces-7602-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5B6C45820
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 10:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB41B4E5F92
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A792FC89F;
	Mon, 10 Nov 2025 09:05:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF5F2F7AA6;
	Mon, 10 Nov 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765532; cv=none; b=mvVlFcMx3nPB5JujjoaWXD/0KIlVQBxRjakgaW3mLr/4VvKeKybpjJHFyXo6j5GGJ5toJAuD5/SqIU06qjPISNIkvqaaCu9x5MV0kRjpEDzUKz/CZGRKXE1vM/qnALeaidZKhwaXhxC5FyKNyq0mWFeg5P/CQNuLygX7aSCyGnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765532; c=relaxed/simple;
	bh=q7iy3M5XtjR+vKa52AD6sRFGTz30GoU7Cr4qhdOdvxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twtfM+Onzpm1wbANhe++KT+FWbWKwricxYcuceZlAswd0RDgy/RMCJlp6XMw7n8sJ9f8gsCVBvXQTC6a4Sa1AXwf8rk+4VGzMHB4OeOBr8s7d4mC0nncoiMVv/rZehuntgEhyhzn9dLv0QKy7Z4p0cRwcsGbE9taE195FIz/0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgAnIWnEqhFpkMNyAA--.16992S2;
	Mon, 10 Nov 2025 17:05:09 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: ben.dooks@codethink.co.uk
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thierry.reding@gmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	greentime.hu@sifive.com,
	jarkko.nikula@linux.intel.com,
	u.kleine-koenig@pengutronix.de,
	linmin@eswincomputing.com,
	dongxuyang@eswincomputing.com
Subject: Re: [PATCH v9 6/6] pwm: dwc: add of/platform support
Date: Mon, 10 Nov 2025 17:05:08 +0800
Message-Id: <20251110090508.739-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20230907161242.67190-7-ben.dooks@codethink.co.uk>
References: <20230907161242.67190-7-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:TAJkCgAnIWnEqhFpkMNyAA--.16992S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO27AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY02Avz4vE-syl42xK82IYc2
	Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUrJ5rDUUUU
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

> The dwc pwm controller can be used in non-PCI systems, so allow=0D
> either platform or OF based probing.=0D
>=0D
=0D
Hi Ben,=0D
=0D
We're currently working on a platform driver for the DW_apb_timers PWM =0D
controller used in our EIC7700 SoC. We noticed that you submitted a patch =
=0D
for a DW PWM platform controller back in 2023, and we would like to kindly =
=0D
ask about its current status. Do you have any plans to get it merged =0D
into mainline?=0D
=0D
Regards,=0D
Xuyang Dong=


