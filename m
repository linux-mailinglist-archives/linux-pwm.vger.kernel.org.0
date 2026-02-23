Return-Path: <linux-pwm+bounces-8149-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMizH+UonGl1AAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8149-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 11:16:05 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F4174B13
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 11:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62984313299F
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809D361644;
	Mon, 23 Feb 2026 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVkWbQQ5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F713612F3
	for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841317; cv=none; b=SUidXq2bWjnm3wq8DUCed9pu3O+i7i3ihMUGnqK0vvz5rM8FHKb+K775lJo5ui0ibnjG1JUiSkGXXVY40hiCWPiGfiB8qFlNuUpFu3FxXBSmCGTdqu/zuLM7OL0XkNsjApdUYnyyJRpGFAQRGkOSVytwp8DQZ1om+LCUx/RbnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841317; c=relaxed/simple;
	bh=fgB/iwLbohKh980nUt8XO9waGZx3cLIN28KQTHavg30=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cn8VgCa8epsHfw+VRLvkj2FRSxYYlvKJ1AssckF76X0XQ2anNOqdcs33shtb/T9HEo9rLEG4gLXN4U/BIZO9GRq5dJjWYnIfPe9hX4OoTlaMCroyzKHJqGuCsxPbUVllxlmuK7h3zLUlZFoMfCsbMQVvcJqIZj/BcQw3RBXGFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CVkWbQQ5; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-65a408f232eso5300256a12.0
        for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 02:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771841314; x=1772446114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wlxVSXIBEWmbvlrro6jhFkd5VzymdyQh6rt270iLHWc=;
        b=CVkWbQQ5Nw2UzIg13fmKwYYfkto5D7nCK/icW4sK686SZ9DPetQkW+7B4p2h7XZuJH
         neivNcqMbqScTwxXHzxnnw3HEkZ59mUCzeZsYmHEyPO5HUYeBJLAvZHX1lo94oprRoGe
         OgqnS+flELXLDswvPqhFXrAsjC3p4p5WTohXOuXBXUQAQQZTgxFtPO6j82n16g407gPW
         /Z9uHcIb97QafON2taanvFk1Ub21TLAQ/XQQudi4WBqHAVnfHuVmmcmMyIqgd57y7MDn
         Nw5I6nxO1DrjEr1Q6vck+uulfmQAGuuTT1B4epH25GqxzkN348gGagNn0yX6T7OLbR79
         Yblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841314; x=1772446114;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlxVSXIBEWmbvlrro6jhFkd5VzymdyQh6rt270iLHWc=;
        b=en7MpUG3H5iqC4+YFgzGwBqDI5g5ykbAFjIGki/X8vpgGrcDARNs2ukQNRe7Fp/cxb
         6U5tZruxQcEePQpw1UcvOJWDHBpWatl9iYlnU8+kAejJ+WhV8xZKqieyzeWZRfEUrr0N
         Oj4jcfxQ9c2gLU9zB5ZHf8njJqpiUSGL8ZqNc1+wMIWUffG/+dtXMLIr4HKWbE8n60YF
         TnCPMrfryIG3y5WWL/TzaFAK/z85M0msy0vn2W8zT12CgopacrdVZaHjjBA7IQi1VhKS
         70vUt/uH8cTmWkgjZm4u/NA9JDQP5rajx0Y3LIPXr5f5CLwBZyavnLeUzP9kPuosEnGw
         7EIw==
X-Forwarded-Encrypted: i=1; AJvYcCUYxoQ7ZNw5rOl5N3GoBT1NkNwSo47uZ4tPqWHQ1mrWiGznEp+yZgj2Xzk7UG7bER9fgJxbHWRb378=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+sRHaQYBLH4ZS9KQBmxnFrxSqZM0VqBxUSp4mdLqxt3oWAE5
	rC/OrL2Ml7aDzY61aLiNzjnJlS8XNNUiP99rMVnfXviP+EZd072BbqqAQViKOooS8r7Bc2leaum
	+4le/jkSBTJbMuR46bA==
X-Received: from edbbc7.prod.google.com ([2002:a05:6402:2047:b0:654:503e:5179])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4017:b0:65c:2120:4055 with SMTP id 4fb4d7f45d1cf-65ea4ef5fc1mr4684466a12.17.1771841313635;
 Mon, 23 Feb 2026 02:08:33 -0800 (PST)
Date: Mon, 23 Feb 2026 10:08:24 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABgnnGkC/3XMQWrDMBCF4asErTNlZjSu5a56j9CFLI8dkcQqV
 jEJwXevEmhLHbJ8D77/arJOUbN521zNpHPMMY1lVNuNCXs/DgqxK9swcoUNCoTjAbKOHeTLGMC
 G3te9KAVlU8znpH0833u7j7L3MX+l6XLPz3R7n5VmAgJxHbK1jNq69yGl4agvIZ3MLTXzLydkX
 HMGBBHfVtZ6RScP3P5xJrfmtnAV17JyT+rDA5cf/opEds2l8Jq4DXXXiK+bf3xZlm9QTlKAaAE AAA==
X-Change-Id: 20250904-clk-send-sync-3cfa7f4e1ce2
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=fgB/iwLbohKh980nUt8XO9waGZx3cLIN28KQTHavg30=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpnCcbiIu+R+hONicI/5HczHhqmbqxSjeE33oZ0
 C7LVlUNYxWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaZwnGwAKCRAEWL7uWMY5
 RjabEACzuGAOA16XYr7603EjsixgD4+MZeZHTazYT1169bUuHnSo3QoKPuZkN1kdkRtOy6YgOnk
 PpsY6nAPlmM0rSpPPTgq9GIYMuxGj8Ncp+2R84WBToDSn61axTSzHSJsE9iF2fGPtV+yQiQ5vo2
 Wr1RWr1ZfNnK0cHGL8ImbArrHUMZH3C/JAQKwPMFCTVUFH3i0LQlMGy44A8oo0yqQpCgqVJKUuj
 G5GT6RLyPmcLcd+7jsV/qaDOGyc+/gkF/yfTDsk0DV5IhgVqsHG7iO5F3Jl6tbX3JRe0q1UtEVe
 7ApNIttnFsBpF5n49tj+RfyrshVI9EjWZE7f4E0eCo8+MBnNgqRyeJfb7UFPh4W0B/G16NfLu38
 SkMbrLJnalt7IfA2B3/Oi8W1jg5K7Rw0NPuRc0X4ws04qON7jEq3TtAjwuj9vbGWzPOAdDCeP9A
 MpQOXyzsTfF9E4Z3QTFYYYEUiVVzK9takPy8oiYp+1AZEH3zMoRp360GegLQK4X1SHi3MhGUzI6
 wgKiWEBU4vSCqHTmcnMwNtuY7551LnVrn5oHjRH27Fe4muJgovNbenKsfGRx2Ud45xKMiKAUCxR
 AM6DCKpA9r8XIfinK5fFvyADHVdFilFkYAf0KOjo+zqa/h8g6WY6BgUNBLHTi13GZumE7phzwrl HXc+BH6rkn6/Ssg==
X-Mailer: b4 0.14.2
Message-ID: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
Subject: [PATCH v5 0/3] Implement Send and Sync for clk
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8149-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 386F4174B13
X-Rspamd-Action: no action

The Clk type is thread-safe, so let's mark it as thread-safe in the type
system. This lets us get rid of hacks in drivers.

For Stephen's clk tree.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v5:
- Rebase on v7.0-rc1.
- Pick up Reviewed-by tags.
- Link to v4: https://lore.kernel.org/r/20260113-clk-send-sync-v4-0-712bc7d94a79@google.com

Changes in v4:
- Pick up Reviewed-by tags.
- Link to v3: https://lore.kernel.org/r/20251218-clk-send-sync-v3-0-e48b2e2f1eac@google.com

Changes in v3:
- Rebase on v6.19-rc1.
- Pick up tags.
- Add fix for pwm driver as well.
- Link to v2: https://lore.kernel.org/r/20251020-clk-send-sync-v2-0-44ab533ae084@google.com

Changes in v2:
- Rebase on v6.18-rc1.
- Add patch to tyr driver.
- Link to v1: https://lore.kernel.org/r/20250904-clk-send-sync-v1-1-48d023320eb8@google.com

---
Alice Ryhl (3):
      rust: clk: implement Send and Sync
      tyr: remove impl Send/Sync for TyrData
      pwm: th1520: remove impl Send/Sync for Th1520PwmDriverData

 drivers/gpu/drm/tyr/driver.rs | 12 ------------
 drivers/pwm/pwm_th1520.rs     | 15 ---------------
 rust/kernel/clk.rs            |  7 +++++++
 3 files changed, 7 insertions(+), 27 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20250904-clk-send-sync-3cfa7f4e1ce2

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


