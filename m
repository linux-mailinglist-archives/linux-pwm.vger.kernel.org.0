Return-Path: <linux-pwm+bounces-8152-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JzuHeconGm7AAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8152-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 11:16:07 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BDD174B1A
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 11:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C35BC3071F4B
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253EB361DB0;
	Mon, 23 Feb 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gz+kDW21"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ADD36164A
	for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841322; cv=none; b=NLQunWGcOm7UzORZlJETmCSI5GB++f8rjh9EbRl77Dn4gEPfFAryuMxIdFfvPG50F0t/QJMUTwN2ih0uLTMCSInXIIUMZoCkp9cwji5EhqJ4xZAZiBbkGthsihiSJq3oMMUd0pSSIpQXkovUMiz4O66wAz0rJZZxU+BNyoWpM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841322; c=relaxed/simple;
	bh=pyY9kK4oV6p5HO7c/+g+XC/Va/dVtmU2Pzel1xZKbW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lbNpU5vNL15cJnrFV/EgpWTsWiPVT5fz9oAYE2JJ+Z9WYCcaIM6LaN51EF1O1UDIkONEHNZeu6VYTPbsK8rRNWsKmQ1r5AJaGaqat+jmSmnp9PZasqyjRpjEFJwznKknYZItGw0VosWj/T2eXolJ3GT4uOFoOqlJIfKChBWVcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gz+kDW21; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso44689085e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 02:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771841317; x=1772446117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=74oBSEu7KeQiZ+IoO0+YkS8FCtMu2JGZ7vr9oRz0PzI=;
        b=gz+kDW21aShQ42gx89RO4N2FPDKFjyt/nXcSzqWPphs7dSFxRDOBzMX2IoFl2Vdqlt
         K3WFxjF45/i6V8Q9H8iC7XpKGOP4X7IGxF9rYz8mfkZBVO+gXruRAi1J7Aw9XdtTWgtM
         B/ByscH+5ewPO9qsB4HPgw2urAjrIE04AspQO1w23PU2dlOny7FOPLqNexMK280w87zz
         SG++UiJQgLpCbqGA7+9l6BWq9B5b+w/w5A4hw8aSBt+n/77QlU81JUlqt6AYmqXfaJ/j
         EQYyMCJFVMAuaj6BEdSVRdy0ub/lJQt2s//eUrW8eVKsEUyL6zXrYVr9qCv1lVoOmZ20
         Yo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841317; x=1772446117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74oBSEu7KeQiZ+IoO0+YkS8FCtMu2JGZ7vr9oRz0PzI=;
        b=o9mgeZJB3JI5IIegZxfSmslCM7q7As62gYoyPE3axjKmwYY4ZDnzZfeL36NDqE6Thy
         UHUIJFav9WAsQSlXOkch5PqRALVQN/NJ0yLunuueU6PB3ZmHlSLo8ljpUJWrBKGipLi7
         SVe5PhH0yJkJwtfRZ4u1n6cF/v/oW4gcTPSzv/xZ31F1rwRKXYe0iuCUnIREAwIIGlR6
         brhTqs8seWWbQJSTncMqI7nYMI4+OYb9987BA+PbrgVUViLPqEQ9l29V4vqqrLBrf0Tu
         FRg9TjBv4AyNkEThznLmetP/k+/iys3rW/OqraSIcRkjXeAEgrTDpA8o4VSd7a79+IAB
         cdMg==
X-Forwarded-Encrypted: i=1; AJvYcCX8VeZ0vJJcMaPDAxgx5q75Y+DccjmL8sAqcCMJHtypNg2b2p1bHb0Pm+v+sNH771VTrw6cDD8hXvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkuynxCNn+hXLL7W0MvV7oFwAH3R7iI3mo/VvnDlHqaOY6ywh9
	zuPtISalALmMa3Nj4yro52nzpmAZ15aWcBGXhQ+JZkLgfgA+kj3S1hzj5hgmJ4YK0Fxvy/x8Vk0
	9iUZBfNynzcLPkD/xxg==
X-Received: from wmqf8.prod.google.com ([2002:a05:600c:4e88:b0:483:509d:729b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6298:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-483a95fc1b2mr131544185e9.12.1771841316659;
 Mon, 23 Feb 2026 02:08:36 -0800 (PST)
Date: Mon, 23 Feb 2026 10:08:26 +0000
In-Reply-To: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=pyY9kK4oV6p5HO7c/+g+XC/Va/dVtmU2Pzel1xZKbW0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpnCcgQsWGO0SyEW1aYXJHNJ1ToG77ov+/VqDIJ
 2Rqb9pykuKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaZwnIAAKCRAEWL7uWMY5
 RvPKEACcCzYO2H2oHLj3JDXRaxmHYGc/SeaInq4aZ2JbFlexxZTT4p23CkD40L5nX9RPxIEFFFi
 c7N8pnaUWanWESy6oExuxMGfeErXamS1NMw1HApdc8c1tN2HuU6S7Ae/5fZodqUPjq58GFujgik
 UjrEnwkWDYYu5Ur0biyjS07f9wtR0nHDaTokNWxkoINedZCvmyz4tHzGFVG+ckuZwdEPQTS2L4H
 suTrShLXwqeePnkJisxZPKyPYYcELHBOB1WnvpYJ9Y+ECidj9mgbPFjQx53XeHyg2Q7aBOa9nxN
 Tvn6x1DKjWkJbFpGOthc8vlwDei8eMV/hPEu5qdjPtogR4LpopTrhVGVqXoVHK0tcmV1gktjxYR
 fA2KrSdElAcjkxQsZWBOSpwOEKp+HjxgeMjatw3CtjYZBAeyKgmG+cGoSvZmKzcD/220WpvoDtK
 NiGtga+cJkHAVUyjDv6XC/R8zp6+ZwmrK0WJdqkIMoQ1vpj52EJBzZDdljwKL3knHM1h5GSlran
 hUcuddCm9qyCl59Tx2TgYGdiUe4UcF3qxsHzSFus/3+kaqkw7jNKs0jyZ40pz4pM+tqkOTQb2ly
 5H3BRIhQ/kZhj+W1ZRRKzRuBj/lunAY1BW8Ry2zahqvU+ESFtSG4uzeTTQQBMCRRPpiPuCstoW4 wHfC88lm6sts2ng==
X-Mailer: b4 0.14.2
Message-ID: <20260223-clk-send-sync-v5-2-181bf2f35652@google.com>
Subject: [PATCH v5 2/3] tyr: remove impl Send/Sync for TyrData
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8152-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,linux.intel.com,kernel.org,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:email,garyguo.net:email]
X-Rspamd-Queue-Id: D7BDD174B1A
X-Rspamd-Action: no action

Now that clk implements Send and Sync, we no longer need to manually
implement these traits for TyrData. Thus remove the implementations.

The comment also mentions the regulator. However, the regulator had the
traits added in commit 9a200cbdb543 ("rust: regulator: implement Send
and Sync for Regulator<T>"), which is already in mainline.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/tyr/driver.rs | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index beeffe36b6cb068f2a87129872b37cbea4fb2010..e833e9f537b0225368ca10f5bc71b2612b0befa5 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -53,18 +53,6 @@ pub(crate) struct TyrData {
     pub(crate) gpu_info: GpuInfo,
 }
 
-// Both `Clk` and `Regulator` do not implement `Send` or `Sync`, but they
-// should. There are patches on the mailing list to address this, but they have
-// not landed yet.
-//
-// For now, add this workaround so that this patch compiles with the promise
-// that it will be removed in a future patch.
-//
-// SAFETY: This will be removed in a future patch.
-unsafe impl Send for TyrData {}
-// SAFETY: This will be removed in a future patch.
-unsafe impl Sync for TyrData {}
-
 fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
     regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
 

-- 
2.53.0.345.g96ddfc5eaa-goog


