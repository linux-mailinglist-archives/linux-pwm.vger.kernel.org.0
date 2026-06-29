Return-Path: <linux-pwm+bounces-9449-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fls0F3XqQWr1vwkAu9opvQ
	(envelope-from <linux-pwm+bounces-9449-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 05:45:57 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEBB6D5B43
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 05:45:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gurudas.dev header.s=spacemail header.b=IK8TBh20;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9449-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9449-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04D0E30277C4
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 03:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F34380FE6;
	Mon, 29 Jun 2026 03:45:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from out-12.smtp.spacemail.com (out-12.smtp.spacemail.com [198.54.127.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59617331ED8;
	Mon, 29 Jun 2026 03:45:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782704704; cv=none; b=NyQ+B5HZcnuawKuMzxc3KH2rovDWWtHqkUwgCYr9lZe4FgVLwB4Lh3B27C0TjXN6JdZcUYZLniy6LCxoh6Z5niu+Lx5qrgKyEoSbGCDBh3dyPRwH/gJ/kKeb0yk0CKDQ83aj1DM+qqGTTHX+CjEm0kPT0tX4Vu71c5FJB0QEGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782704704; c=relaxed/simple;
	bh=QbkbgEcDOp8DemVXI/V0dpeBMUXkEeOhRVWsw1KUqmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrJ/pDl9BPgYYBcOI2GTnxsspjuzbMYWB7ECEF8WYRHdMzBI3xeUsLqQaFuJ4OlHVVHos48c4EmmgbO/zsuqnl7TCqADlwycTrWbOIUur+hpDBq49rypabnyAK/L2jGA6R0NX8clL0iUmJ8mRYtURWanxf1AVXAJALGYndFMSE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=IK8TBh20; arc=none smtp.client-ip=198.54.127.83
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gpX7P59qNz8sbj;
	Mon, 29 Jun 2026 03:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1782704324;
	bh=jKx+94n82aR0aGPCo9y8gNwhGoiI7gsWMuBc5ujvVUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IK8TBh20FCaBU8hFE79rDS1IeLvUpmNeCrw1Xd/aj5CmfYaTmvloJz6AXTa8HAIFS
	 kGP9eqO+IXWFu5ldt1V5SUuyTagyiqAl+5AKruDwebOg5E1gf2iFIKx8ojXCS5CmFW
	 ABawlfgtTdXozg5f4yPPc+oF5Qmhhud6oDvUyvRbespTxwCa5/tak5hZlxH+yzoohL
	 9hfkhZUFjHej2hQNNmjGkzHYxmnWOwEIOmwMi/Vq8rqE30d/SeQmb4dup9V1hVfRQV
	 CQ7AEOZKORM64XTLXgFWxzHQPrXbrC9eNiDqL9u7+D0Lt0ALP0jZN84WzoTbSRzsqb
	 XxS+9tq6GQdRw==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 28 Jun 2026 20:38:21 -0700
Subject: [PATCH 7/7] drm/nova: use vertical import style
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-b4-rust-vertical-imports-v1-7-98bc71d4810b@gurudas.dev>
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
To: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 driver-core@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-block@vger.kernel.org, netdev@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gurudas.dev:s=spacemail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ojeda@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dakr@kernel.org,m:abdiel.janulgue@gmail.com,m:daniel.almeida@collabora.com,m:robin.murphy@arm.com,m:a.hindborg@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:axboe@kernel.dk,m:fujita.tomonori@gmail.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:driver-core@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-block@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.
 linux.dev,m:dri-devel@lists.freedesktop.org,m:linux@gurudas.dev,m:abdieljanulgue@gmail.com,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[linux@gurudas.dev,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9449-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[44];
	DMARC_NA(0.00)[gurudas.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gurudas.dev:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@gurudas.dev,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,collabora.com,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,onurozkan.dev,redhat.com,samsung.com,linaro.org,kernel.dk,lunn.ch,armlinux.org.uk,davemloft.net,ffwll.ch,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.freedesktop.org,gurudas.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gurudas.dev:dkim,gurudas.dev:email,gurudas.dev:mid,gurudas.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCEBB6D5B43

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 drivers/gpu/drm/nova/file.rs | 5 ++++-
 drivers/gpu/drm/nova/gem.rs  | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index a3b7bd36792c..9a1404a7a687 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -4,7 +4,10 @@
 use crate::gem::NovaObject;
 use kernel::{
     alloc::flags::*,
-    drm::{self, gem::BaseObject},
+    drm::{
+        self,
+        gem::BaseObject, //
+    },
     pci,
     prelude::*,
     uapi,
diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
index 9d8ff7de2c0f..f6bc7fdee732 100644
--- a/drivers/gpu/drm/nova/gem.rs
+++ b/drivers/gpu/drm/nova/gem.rs
@@ -2,7 +2,11 @@
 
 use kernel::{
     drm,
-    drm::{gem, gem::BaseObject, DeviceContext},
+    drm::{
+        gem,
+        gem::BaseObject,
+        DeviceContext, //
+    },
     page,
     prelude::*,
     sync::aref::ARef,

-- 
2.54.0


