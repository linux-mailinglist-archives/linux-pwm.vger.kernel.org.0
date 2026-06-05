Return-Path: <linux-pwm+bounces-9258-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wUZmCI51ImrrXgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9258-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 09:06:54 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1768C645C58
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 09:06:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=KGElozfF;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=B9mdvrtu;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9258-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9258-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DAB330290A0
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2026 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B444CAEA;
	Fri,  5 Jun 2026 07:01:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D244CF56;
	Fri,  5 Jun 2026 07:01:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642867; cv=none; b=McemWhimCrei2vFKhB0AJF00lJ3Coqmzc56Oye0le/XH87SnHw1YMjG/VYbj0VjFh0pv2RflVecPaYuYz1kSGjouR8cpaQUOO47JSPJU0hjkGv1xq97+xQ8GDYD3vvP6U0dRFcztflTg4gqSmfHEsm863LGHBqyi6hTvATpnBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642867; c=relaxed/simple;
	bh=7AgV/jvCGRHNYi9UE7Sn1mIc5P3fU81aRL5N8wcCv8w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q9VYV//ERCNDvE6zpDKwqHgeB6W2/zjf3eRAEznS+nClD77eZSpgQ72o9hYP761mTu0aHNG0Zx8Pwve4L4WVluxOpr2XPwDOmB3VfgSvefwXzgSHMVkVEh3DuF964gwYibdD0GVVfivjDd3nd45YEVjEbsAFI9muAFYOjbcD3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KGElozfF; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=B9mdvrtu; arc=none smtp.client-ip=80.241.56.152
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gWslr1N5Rz9v9m;
	Fri,  5 Jun 2026 09:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780642856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ok3grrEVy8++TcZAk4/8hJa1q3Dyot3JENfiZb1Bh5o=;
	b=KGElozfFeWoSUsHggk+MGm+Gcj/16XxxmZFWnXSyx/iDqA4qmePnJkRBrcLNuZUQfz3WXs
	7TDnmxPE5FZvWurzHyoL70eaChcwMsfithUyOUj5LngmS1CVEtZUMGCLQUc29Xz/nU7KbB
	YJFxRqpYAG+AynG6wglcARBC6UKLv8CFIFx2FOJtL2CxIzQjOmzu9XBc5b/IU0fVWQsOHe
	NhtFTN94hezfxPkKdTBUDjx4iE1Rw+b8yMyjZEldjqgkJp23+HvcdpH5FYSkNXbhoCDVC1
	79QKmCAk8n2Z4e7AOFa50Ise4DVyaIoT6FUUITF3pucVC1d33BBqbNkheF1ksg==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780642849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ok3grrEVy8++TcZAk4/8hJa1q3Dyot3JENfiZb1Bh5o=;
	b=B9mdvrtulAX0Myi4wyYoU9wm7PAZ/NE1gKqig0Feg/z6bQnOM0LWswaDKoDYgppGMk6NAA
	fLaokrGDJ7hBUpPhUQVNwjZ+/grao7zF0Ob2uB2cS6MGVykNo6kCkHQNPvz4/61Zj4+ydt
	TBUjARVdHYkVU6M9R2W1Ds6z8BLmw+8qHc5e0pIfXvcMZ8H2XH7+FSBUoe+jFErQ6Ju210
	co8hpJFXEtwUlUzrtyFYiXRF6dH3am6hfP8dxlhPs1GtPRWF5NDSzv4JyabBMOhS5iTydi
	7nh2NRFRxcTQLEdnF2FFHrG3P6Crji6rW5eoRy9m/yPVARPDKGm9Kvq4IU2PhA==
Subject: [PATCH v2 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
Date: Fri, 05 Jun 2026 08:59:58 +0200
Message-Id: <20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7Zi2FBRX3sOwqDDAJEhJW5saw
 t2tnMDl+8l/bwNPjsnDrdjAUWTPdsmgTgV0k1lGQu4zgxKqFpWq0ZlASKmb354j4UgBwyQrJfB
 Sa9Popid5Jcj/1dHA6XA/2swT+2Dd50hF+Vv/sUaJAkvdDaLUJHPj/jI8P206WzdCu+/7FzTEv
 qnEAAAA
X-Change-ID: 20260526-rate-exclusive-get-th1520-764a949de18e
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780642818; l=1057;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=7AgV/jvCGRHNYi9UE7Sn1mIc5P3fU81aRL5N8wcCv8w=;
 b=MQ9ALBSr14fgkGxYrTIqDCq8RAvbwrzksThQHaFqK0YN3At+av9LQpU5i58S2+6cLMboqKJdq
 63OUxc1rFroDOE3wkR5hTTdLetppbU/ymDT5LtloDUS5JF8zEvQySOD
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: pqwz9dnzqb5jncw8f6pzxerow7tykiuk
X-MBO-RS-ID: a64c37f4287a6ee13a7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:mhi@mailbox.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9258-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,redhat.com,samsung.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mailbox.org:mid,mailbox.org:dkim,mailbox.org:from_mime,mailbox.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1768C645C58

Add a Rust binding for clk_rate_exclusive_get() / clk_rate_exclusive_put()
and use it in pwm-th1520, which previously carried a TODO noting the
missing binding.

Based on pwm/for-next.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Changes in v2:
- Rebase on pwm/for-next
- Remove newline after [`clk_rate_exclusive_get`] comment
- Remove unused [`struct clk`] link
- Put semicolon outside of unsafe block
- Link to v1: https://lore.kernel.org/r/20260526-rate-exclusive-get-th1520-v1-0-34cf034e1764@mailbox.org

---
Maurice Hieronymus (2):
      rust: clk: Add ExclusiveClk wrapper for clk_rate_exclusive_get
      pwm: th1520: Lock clock rate with clk_rate_exclusive_get

 drivers/pwm/pwm_th1520.rs |  8 +++----
 rust/kernel/clk.rs        | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 5 deletions(-)
---
base-commit: 5b5e33c44a491d5b5e019f527e028bd567a226fa
change-id: 20260526-rate-exclusive-get-th1520-764a949de18e

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>


