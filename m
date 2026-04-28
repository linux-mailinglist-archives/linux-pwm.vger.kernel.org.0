Return-Path: <linux-pwm+bounces-8737-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AQHM2+V8GnnVAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8737-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 13:09:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEFF483583
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 13:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC81B308D40A
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E136D3932DB;
	Tue, 28 Apr 2026 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTUXuWMr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7038F658;
	Tue, 28 Apr 2026 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373246; cv=none; b=SM43lw9vZd1ancHTbAjz3uNpp76SDFjc7IaoWdwVWWpE9PFTvAWzak4lMyrsGF283Vu6SaMcVSvV//XphBjyOnRZfFp/KS1ynU3wN0IiYsjqS4TTIyXOO8JEIEVbpgtKTHEn7sezhnAhXEBsLpVmQZ03HNhXMKi915XPIey8AFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373246; c=relaxed/simple;
	bh=hmQkgfT0rpHX0CJzE2hZUP7HWCGF2gixhN4JwZLv+JA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fQl+5Z0t5tT0aTSdZfiO9iAo6OQZxNPgA2fueCdj+KqfSdeM58Sqknn1lghAJ1+HFjrK9HJnO120z9W/UXiaS8lo9bfUI+DGw8un5dl/A6VfAGTKi9jY6yzkUZEgZ1xHygoPFXkYbys2eDgBPcVtNqDbYykGGKu6T7XGjhDM8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTUXuWMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E14C2BCB5;
	Tue, 28 Apr 2026 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777373246;
	bh=hmQkgfT0rpHX0CJzE2hZUP7HWCGF2gixhN4JwZLv+JA=;
	h=From:Subject:Date:To:Cc:From;
	b=pTUXuWMrnk8VsUalenBFv70B0MEXJ4/R5rM2VjC4M/M85xBPQcfXCRadYII+zSf5/
	 kz7VuwVZI5KeV5qBpReRKf8Rm6KjCcTnl3mdvyh7LNyK5MBWGOJ7Uo1Pu19LXC1ypb
	 bRk35Xutgk/B0dk62/C5Q5TwfdU8N4lh8ZZaP6o9ThCllGdYkhuMWghl10cJaQrkZE
	 h0sn3Zb1feyTOo4uQPT/mKFr7I3dy49xkg1n5diH47jaoMQGUBphbSr1k/qsCsoE0z
	 rWi0iaLvzzi8b/+TWu7NwG0xgfFZ+9bewT6QNidFI2E40lkpxDwLF7ALf/h6sealpX
	 5e5poB5xHn3fw==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH v2 0/2] pwm: spacemit: Add Support for K3 SoC
Date: Tue, 28 Apr 2026 10:46:49 +0000
Message-Id: <20260428-03-k3-pwm-drv-v2-0-a532bbe45556@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABmQ8GkC/13MQQ6CMBCF4auQWTumpVCFlfcwLKoMMEEpmZqqI
 dzdSuLG5f+S9y0QSJgC1NkCQpED+ylFvsvgOripJ+Q2NeQqt6pQGpXB0eD8vGMrEQtyVeXIlGV
 rIX1moY5fm3duUg8cHl7eGx/1d/1J1Z8UE43aqINTtrs4czyNJBPd9l56aNZ1/QCG0OxfqwAAA
 A==
X-Change-ID: 20260401-03-k3-pwm-drv-4ea99ae355d6
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=dlan@kernel.org;
 h=from:subject:message-id; bh=hmQkgfT0rpHX0CJzE2hZUP7HWCGF2gixhN4JwZLv+JA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBp8JAwdWxf31B4X/UYDlsnNNL/sigdLdKjBqX4K
 1SnRRj9eaOJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCafCQMBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3GTg/9GubtELYf0rDa3bh0lEVik0BCce7hVSMXtGLQSH7NNgY0Vs/aVS8TE
 8euy3CzBPvYB3BheBE1d3rh9xUJhBXBfgGyi3reM6J4f2z4yXjXix/TOcdHJnlv3Pxl5mILEl1X
 7O2dzpUrRStl1nx/OMJDIH1NgwkEJcFOelSfVd4g9LlKmlKytREZFZ2rdSeYhWEywwPcMn2IEYf
 Fh4bKanfT7FHyG16aFk7lP+kPH/wihe1vJDrZhdXBAQeaI5YzfVfAayF0HI5yN7cokTsIxtYtWP
 S3RkTP/cZi7Y2rwSL1AdTK42Lg4XMG4mg3VKKTz5xfp4GXzFGISHc6Zrycydwva3OgUjbfwUjP9
 vG673vNWkiGn/Kcac5kaxKlTebWaQ9DjeSCe6Ce7RPrrLxG8OV/B2dlIfMaGfLk0JpOsJaKRJHc
 NyNZuoFUFJaUa1QNQBNowu0Mr/fZIua1gi3NFY4HDtT22tj0UaBVKME9jRjCKoSaZoCRvbv1G+p
 PkSYJrlBMOKBSMXc0AiDvXJ4R2LrjU7OhKxXFNFY9cmMdMaDJ/Y85xkYy3ce3gsfUqreW4xbVTm
 h4iaMC0SQ8a2yLZaO1GD1HQ5583AJG+p/5Xem7pMrQfBPhYvmuhLiWhi8ndImG7OL/xOXSUMqrn
 3Wm6Tat+y3tnCarFNoQUG1M1ePjlVQ=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-Rspamd-Queue-Id: 6FEFF483583
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8737-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

The PWM controller in SpacemiT K3 SoC reuse the same IP as previous K1
generation, while the difference is that one additional bus clock is
added. Introduce a new compatible string and also adjust driver code to
support it.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Changes in v2:
- Merge dt-binding of clock-names property
- Use local variable for bus clock
- Rebase to v7.1-rc1
- Link to v1: https://lore.kernel.org/r/20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org

---
Yixun Lan (2):
      dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K3 PWM support
      pwm: pxa: Add optional bus clock

 .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   | 41 ++++++++++++++++++++--
 drivers/pwm/pwm-pxa.c                              |  8 ++++-
 2 files changed, 45 insertions(+), 4 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260401-03-k3-pwm-drv-4ea99ae355d6

Best regards,
-- 
Yixun Lan <dlan@kernel.org>


