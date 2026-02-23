Return-Path: <linux-pwm+bounces-8151-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HeCKLconGm7AAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8151-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 11:15:19 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12007174AD7
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 11:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F42530E6CA3
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0C5361DAC;
	Mon, 23 Feb 2026 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pi+8rdk7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5D36166F
	for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841321; cv=none; b=c/F4NkGWLwYCr8uri0X+UU4C2XgLSfaUbTUTtv3p6GvSgdOeTyBg93iTXAcAa/bsrjntsa7M9hb4+FacA21+8lx8Qj8Rbj+4iMMZtXXyrit+EzmSvpbCNhL9GnSxPXSA6TekoRLUjZAw1ht0fZ0b78GyvFCGXz44C3duTOxt5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841321; c=relaxed/simple;
	bh=+Vwn2RMiQCLbhdbFzxMNsyo+6P3BWAiCt7b4ppvm0lc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gco2+OoeKUZQ4XnTsGOp9qp7OQJgwkSJ+SswNyDIYFA4ili7mRkZsjDR58vX9rRdq29vyGeCSRBQwxiIvcJsfFISIrkJszaoEdac0vEheJNfiO7WHOuTUXxj1keHxrFc9I+l0J2+UEJkOQdwa1s5arOPKZ/M2fKZSlbEiDMdM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pi+8rdk7; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8d78d3fabfso349471666b.3
        for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 02:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771841319; x=1772446119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdnKcgHkjFRmgggTpTfgYETTa8fsvbvkTrjIctXuE0E=;
        b=pi+8rdk7qhbkmTrlMOBUPZ4jNC+DQ0xjprhXSbsJ3gCUHo9KrP7Lr7kLV0x6grSMs6
         bU784O7TMnQAtQCyLHde1W9HWXBa7ONXfzoQ5YFxLMovRBaydbTe0heF7NklvzKeDRVb
         868hZ8iuwZgo7R2AuTN25BgBFcdm7lbCNm2yKfn1oGwiKeyU9ADqezMoLGAKYG/jXBT6
         bCaaP4vUbDhGHHODN3auskIP0Zm/sz0JTsQe4re8jp+UZG4j/33S48aqQTNR2rCJkAny
         wIm3DzEWj15C5naxm4Ts27n9ZHIwTaMn2LgYozV9C6Y7xGgP8OvC81SdE+NLzDrVK7pF
         1jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841319; x=1772446119;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OdnKcgHkjFRmgggTpTfgYETTa8fsvbvkTrjIctXuE0E=;
        b=Stl1dFg5X7q9WOuecJ8hrijACGGocugopZ+t3Wev4nvOTrOi7LY+A6JMeGbmZZcBMr
         00H3BoWC8TCfENnrZWXE7oVsnGgLddwm1+oe4NN8TW1EHXhH4ZyISBWvSMllQUwT8GXi
         QYFw7oSU2KIl3ewnW6nwABBuiZd6Bk19sTM/N6tMZXkbvSRki4FaUuXvv7y9bliUDvUK
         gXQw+vVf9uP3P31Q5WEKQ4po9dQDHGBFpQHh8+qp2crrocEtNbx1HeQcCt/jBCE7AFM6
         tE38ukNoG0iYPuK222yMex4j03HEvlezqzkeVuh2fl4WnO5XmPFD82IJyNDjEZ66CqQG
         gDew==
X-Forwarded-Encrypted: i=1; AJvYcCUuwDdqyWqzIpp84/QhGIG4/GHt7HJSZS7XY4MR/oepnHoLEgFs/4oucJLCJaTjlYHNDN1NAWirJOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kMNHhGFAsBF9TnEf0KfKaWheSo7gpXha3dOYEFKuLplYJslO
	5g2YC+0DXS3+Pl4gl6tMLJ9dSOsvk7i13xkL9KKGgGdtVaadc65IwVbotyfo+jdKDvf3hEUXNaj
	j2eXrBxrSVG5C0TCcWw==
X-Received: from edgi6-n1.prod.google.com ([2002:a05:6402:a586:10b0:659:32e4:b9bf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e25:b0:b8f:ad6:db92 with SMTP id a640c23a62f3a-b908196acb2mr410233066b.3.1771841318227;
 Mon, 23 Feb 2026 02:08:38 -0800 (PST)
Date: Mon, 23 Feb 2026 10:08:27 +0000
In-Reply-To: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=jAawhmP9tDMdeWRIiWq9BA5B+z9O+mAwAwRx1JUlWqQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpnCcgbTxLXepdurAu3GuF7CkmSYRcJGHXg5wHK
 hhZLv4P056JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaZwnIAAKCRAEWL7uWMY5
 Rmg5EACUr4q9yVqlI5z1xy9rbC8EGqAU70l/fbrINwUJqLf9Vt3GtkZDEI/b6AlgN8RQX4mTF5N
 HbhQXKgYr3ZoF6FEaPGouSxpJfyULOX2dOGt9yKD2+/TUDXWtEMqF3IUZi2EVrynHGVLOQ73+m+
 2f9n2iLzZXtFHFAqD6y2m4alR5jk3jY3z6OJxCUBgZsPNs0LI7md9QylC/vN1NfF5gvEv/QouDJ
 soiXmdHJCUYyBnyOsmDvPwMu/fbl+x92jpt87qPSH9hLWfJbGFojiA/aPlR2W3jIJCkbCVMntgY
 1Ae/ApT2P85bQovYJ1xpIrQ3H0f6ywsWkuPhtEderymKHmGPSukBCAx9tbtw9kt8rX+Osg8+grg
 fg8/woo0bSdW0aIwDRIeUpet1ZR6eMqgjOoJyYt3ECDnWWOZrj61nr1OPmCuQAIMqcYD8rT2XxM
 nJ73kRZ3WpHs5JtCSYUPj+qacn/BhfJdTlXQrHmhF3ZYoHv+bJv+XYe/Z6b5rSx9PXx+nQb5Bg9
 TrnpR3YQeos5D8NteZVWdTP/iLDuezjrC85tGipCA7HdZgQpAhFbDQn7ump6S53j+KhQ/g62O6M
 Vaaurm+dt3EGb3ZPkYJiKXj1PZ10PFUfFE7r/ZFauGbCVwih6pBzgXs3nTUUkcLAP8gj6dP9+Zi c6sJUxRyO1VAaWg==
X-Mailer: b4 0.14.2
Message-ID: <20260223-clk-send-sync-v5-3-181bf2f35652@google.com>
Subject: [PATCH v5 3/3] pwm: th1520: remove impl Send/Sync for Th1520PwmDriverData
From: Alice Ryhl <aliceryhl@google.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	"=?utf-8?q?Uwe_Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8151-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,linux.intel.com,kernel.org,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email,samsung.com:email]
X-Rspamd-Queue-Id: 12007174AD7
X-Rspamd-Action: no action

Now that clk implements Send and Sync, we no longer need to manually
implement these traits for Th1520PwmDriverData. Thus remove the
implementations.

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/pwm/pwm_th1520.rs | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index b0e24ee724e4501b812e5f9c7904b483bfe5e2dc..6cd6fa3d298484cbd84b88cfdd3=
244217855fa05 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -99,21 +99,6 @@ struct Th1520PwmDriverData {
     clk: Clk,
 }
=20
-// This `unsafe` implementation is a temporary necessity because the under=
lying `kernel::clk::Clk`
-// type does not yet expose `Send` and `Sync` implementations. This block =
should be removed
-// as soon as the clock abstraction provides these guarantees directly.
-// TODO: Remove those unsafe impl's when Clk will support them itself.
-
-// SAFETY: The `devres` framework requires the driver's private data to be=
 `Send` and `Sync`.
-// We can guarantee this because the PWM core synchronizes all callbacks, =
preventing concurrent
-// access to the contained `iomem` and `clk` resources.
-unsafe impl Send for Th1520PwmDriverData {}
-
-// SAFETY: The same reasoning applies as for `Send`. The PWM core's synchr=
onization
-// guarantees that it is safe for multiple threads to have shared access (=
`&self`)
-// to the driver data during callbacks.
-unsafe impl Sync for Th1520PwmDriverData {}
-
 impl pwm::PwmOps for Th1520PwmDriverData {
     type WfHw =3D Th1520WfHw;
=20

--=20
2.53.0.345.g96ddfc5eaa-goog


