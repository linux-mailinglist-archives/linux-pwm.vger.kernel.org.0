Return-Path: <linux-pwm+bounces-4770-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6495A2871F
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 10:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381633A2721
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D89822A80E;
	Wed,  5 Feb 2025 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dpUJgdAv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4591D7985;
	Wed,  5 Feb 2025 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749354; cv=none; b=i1UFy0VBbomJ7lBTHdW4JF6tlWndM3pQU4QqGsaRa+Iw/sD7nZSB+Cpv4MMDfDVgCQWQZyFUnJDS8bBnQ6L+Pzvw3eKp7Zp4TgvsV78rBf/mADgwR5C/MmpgkFDjleYLhaBNgYsnbWFqLtQSUmyUOFdXpoNZVXyPZrixq4gwbYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749354; c=relaxed/simple;
	bh=YwytP/lkUK7d8CnnjA+s7S91jCBEZ2Fpd6Ws//b0/uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lVL7lNTCV+YaJf2F4T5W3CBRvWzilAiuzRdhA7OJVVB3UR2dRehxADW27H6RE+iLHAD8txTp0teP+mi70PnUFunk/cSs74nY/Wg+VOCfBIr7tW7k4RNNZGLqN6kvAUpHv+jrVwi/2x7AUTMwlylrgR98lfu7CedKGrJLUBB0eyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dpUJgdAv; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 3FA074340A;
	Wed,  5 Feb 2025 09:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738749349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WkkKXNGf6/83mCN+VTO71QRPJh1MmjlW1WXgdCu5wKM=;
	b=dpUJgdAv8g/4sHTOpUugn00zMR6KglT17NGV4EHA8FgFyLBF08Oxb7sF9MG6jclU7AjqMA
	dU0GOxYPgT5DLf5SKdUSUXhWPqQAalUB46fDOTx0uKA3XUMC17rwhXMu0cuGmzXN3LyDP4
	63D9zUQ6+HjxEcQu4pI7A2N6DySPQVa+9CUfPs/+xgVrYVvAbIoCnGA0LXiOVTfbSK1L0C
	dCpHZu9WDhIQ4M3Ud9LsscxYW48OIxPDC4xL1w4fY/QJRdWj2rAm6CKHa1xRuy6xBmLVcR
	APQhkEaUrHTCjP/ypVxo6EbPWQ00Ix+lmiB7GmY6Bb92ccwZwJHFtkvli1whCA==
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
Subject: [PATCH v3 0/2] pwm: Add support for pwm nexus node
Date: Wed,  5 Feb 2025 10:55:41 +0100
Message-ID: <20250205095547.536083-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefjvghrvhgvucevohguihhnrgcuoehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueekkedtieehhfefvdffheekkedufeetfeeulefgudevvedvledtveefveejudetnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgdphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqphifmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: herve.codina@bootlin.com

Platforms can have a standardized connector/expansion slot that exposes
PWMs signals to expansion boards.

A nexus node [1] allows to remap a phandle list in a consumer node
through a connector node in a generic way. With this remapping, the
consumer node needs to know only about the nexus node. Resources behind
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

[1] https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#nexus-nodes-and-specifier-mapping

Compared to previous iteration, this v3 series mainly adds the PWM nexus node
devicetree binding.

Best regards,
Hervé Codina

Changes v2 -> v3
  - Patch 1 (new patch)
    devicetree binding

  - Patch 2 (single patch in v2)
    Fix typos in commit log DT example.
    Avoid wildcard for PWM nexus node properties in the commit log.

Changes v1 -> v2
  v1: https://lore.kernel.org/all/20241202164459.157672-1-herve.codina@bootlin.com/

  - Rework commit log

Herve Codina (2):
  dt-bindings: pwm: Add support for PWM nexus node
  pwm: Add support for pwm nexus dt bindings

 .../bindings/pwm/pwm-nexus-node.yaml          | 65 +++++++++++++++++++
 drivers/pwm/core.c                            |  3 +-
 2 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-nexus-node.yaml

-- 
2.47.1


