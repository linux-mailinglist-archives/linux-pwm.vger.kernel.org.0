Return-Path: <linux-pwm+bounces-4772-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EEBA28723
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 10:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CBA3A2A42
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B8B22ACEE;
	Wed,  5 Feb 2025 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f85GYVav"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E722A4ED;
	Wed,  5 Feb 2025 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749354; cv=none; b=KOwMYo8dPwU9lOSU9kiha4LvFUV9Ex1G4b8Pbrrqe/7OlOL+P/Eqb/KFS+NDzEsbYfwPn+2ecCzhShjGZKDsh/GABiDkrtFMBf12Y2hJUdgF8iu1MHNSkiJPF0PJTGoqIVFf8DOdnpKLJnw8AJG6MfZvu109TtVuWpmjuDSipAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749354; c=relaxed/simple;
	bh=juUmvjJB6cYN04ExXM8nyniU2O+Plp7bVycEkuK8aAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llkGPt0o33UaUGZRJqtXlcTmIaT+M0fEuL52DWevN77YoIooFc5FAnqw6V8PEWjBTpKa7ufQl75pnGsGZNr3uoovgjjpMc84gT7MgA/d7eX8E6Mh4nTTevyC34mA8ozGd/e7VbHCxIRMhkyLfc8YYX/9yFmkZr25/tX19GSJwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f85GYVav; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 6C44C43419;
	Wed,  5 Feb 2025 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738749350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1Q/Kgs+ZlVqX6ytI6zaw2RB7jNNEUJCoJx72kvQuBk=;
	b=f85GYVavlQpiXP+nIwAuKxYgQlFS65E6POm8Hqwj9Fb8MRvDCMH6J7ji/3TpCY87zMnZ+j
	1YMJG7FkuxJrezZvXB83XlJH6Ya7HiTUmZYXGSVnP5e0ZK2tHRNZA2jkvApc8oMwrbyxO5
	x8ArXop3f0yagd3yRo1aGGbtVnTyWWGO51Xf04cFKvxjJItdzkz0g2DMWKlXWtzQlu0tIZ
	avsxCrgFG5B1LJV5prXzf6XhwWeblwNteglHfnX7U7DByeII4zAFxOWEEl+q7bPvS1V5oy
	+eSR/S+EBjPl/EPzGmBRm7aMlgPXjcekMTZ3NNcfpQhOzOLU5AdFy52ZrIgNlw==
From: Herve Codina <herve.codina@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 2/2] pwm: Add support for pwm nexus dt bindings
Date: Wed,  5 Feb 2025 10:55:43 +0100
Message-ID: <20250205095547.536083-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250205095547.536083-1-herve.codina@bootlin.com>
References: <20250205095547.536083-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuuddtvedthedtgfeugeeujeetueehjeffteevtdeugfffffdufedtuedvgeelfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgdphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqphifmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: herve.codina@bootlin.com

Platforms can have a standardized connector/expansion slot that exposes
signals like PWMs to expansion boards in an SoC agnostic way.

The support for nexus node [1] has been added to handle those cases in
commit bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through
a nexus node"). This commit introduced of_parse_phandle_with_args_map()
to handle nexus nodes in a generic way and the gpio subsystem adopted
the support in commit c11e6f0f04db ("gpio: Support gpio nexus dt
bindings").

A nexus node allows to remap a phandle list in a consumer node through a
connector node in a generic way. With this remapping supported, the
consumer node needs to knwow only about the nexus node. Resources behind
the nexus node are decoupled by the nexus node itself.

This is particularly useful when this consumer is described in a
device-tree overlay. Indeed, to have the exact same overlay reused with
several base systems the overlay needs to known only about the connector
is going to be applied to without any knowledge of the SoC (or the
component providing the resource) available in the system.

As an example, suppose 3 PWMs connected to a connector. The connector
PWM 0 and 2 comes from the PWM 1 and 3 of the pwm-controller1. The
connector PWM 1 comes from the PWM 4 of the pwm-controller2. An
expansion device is connected to the connector and uses the connector
PMW 1.

Nexus node support in PWM allows the following description:
	soc {
		soc_pwm1: pwm-controller1 {
			#pwm-cells = <3>;
		};

		soc_pwm2: pwm-controller2 {
			#pwm-cells = <3>;
		};
	};

	connector: connector {
		#pwm-cells = <3>;
		pwm-map = <0 0 0 &soc_pwm1 1 0 0>,
			  <1 0 0 &soc_pwm2 4 0 0>,
			  <2 0 0 &soc_pwm1 3 0 0>;
		pwm-map-mask = <0xffffffff 0x0 0x0>;
		pwm-map-pass-thru = <0x0 0xffffffff 0xffffffff>;
	};

	expansion_device {
		pwms = <&connector 1 57000 0>;
	};

From the expansion device point of view, the PWM requested is the PWM 1
available at the connector regardless of the exact PWM wired to this
connector PWM 1. Thanks to nexus node remapping described at connector
node, this PWM is the PWM 4 of the pwm-controller2.

The nexus node remapping handling consists in handling #pwm-cells,
pwm-map, pwm-map-mask and pwm-map-pass-thru properties. This is already
supported by of_parse_phandle_with_args_map() thanks to its stem_name
parameter.

Add support for nexus node device-tree binding and the related remapping
in the PWM subsystem by simply using of_parse_phandle_with_args_map()
instead of of_parse_phandle_with_args().

[1] https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#nexus-nodes-and-specifier-mapping

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pwm/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ccd54c089bab..a4eedf09922d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1716,8 +1716,7 @@ static struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
 			return ERR_PTR(index);
 	}
 
-	err = of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
-					 &args);
+	err = of_parse_phandle_with_args_map(np, "pwms", "pwm", index, &args);
 	if (err) {
 		pr_err("%s(): can't parse \"pwms\" property\n", __func__);
 		return ERR_PTR(err);
-- 
2.47.1


