Return-Path: <linux-pwm+bounces-9256-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KSuSChVfIWrzFAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9256-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 13:18:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0AF63F5BE
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 13:18:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=BFrvfGuN;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9256-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9256-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30C5C3024916
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAFD40FDAA;
	Thu,  4 Jun 2026 11:17:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44D40B6CF
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2026 11:17:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571864; cv=none; b=rEQ66qiYeUGZnSOdSRUrS7s9XnymhxY0G2YWHYST49NR6mD8uw/ACzyVSdDY7SRiXKfUWeGfnmf+y5zhsfpsfZZxLvb3HXOYGV1nieUBfDbkU80upDq+jBS1NNIuq3fpwz7rod3+1anBW1YyW9gX5wVhFcRR7+OKi/vBe+OahQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571864; c=relaxed/simple;
	bh=RXDUQowYZh9h3j6qG/zfu8NnZV/DxLiYcI7PD6e6SN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZtgX9K31RhVZTttKBHW80fk3jcn6U7Wj5F28lAc161koUTeqsQkl34bV+4EbyrgsUi2Q43kzIu1OMoUG3yNWF8biUPFdYMzoE/bhZgP2/4GfHeFJp8JaFiOg2T8cYo7HkJkp59cPQQNd56go3IAJCND1dDGlEtRN97iJ57INQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFrvfGuN; arc=none smtp.client-ip=209.85.128.74
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490a767b782so4920995e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2026 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780571862; x=1781176662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vMPINAxbwMQr+CA+jaOG7PHibBNPmddYJIp5CCiKSfg=;
        b=BFrvfGuN9oSDubYLaDAS12jTS2M9OlRJFlUWVTwP6kmkTbVQa2dp/a8oxL4WYPzQRy
         bkxb3TVNVb8zWvUQVHOO7g46rXwpQCbzxoqgWm2WixoOeY9B7cRdvnZPRcehGmDZuAj8
         mJH1C6OIEyN6q/l+ds7kJaKhp7iTaG5kwhrSm31hED1jTHEv4IhJSRWYJEV/I1mNsFdJ
         9cKklyICIuWnj5fAfA8I2CKYwEu6YJraNEMv8491k7Hm99R/WsXYK60yo7mjoYk3wWzq
         xzcvpe8ywrG1BwVL4O1rgspzZXieoViS3Nf5Wd6OOn9/7R8aOHUnmr7sYpSBcJbdwA7X
         xuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780571862; x=1781176662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMPINAxbwMQr+CA+jaOG7PHibBNPmddYJIp5CCiKSfg=;
        b=lZ7S4vnT/MVTmz/V2niO8TZWnOXvf80F1ZvzA8sX6ctpdOdjja8TsmF8jOF2UpGm/L
         fNL/GEcm6dsp8ZybNb7KXdhK4DNYzazSNRrijLkHuJvWwy3poTfXw7699hORBsWD7JjY
         QEm4ub7p/z5SQHDfZjlMKbjV7KVzd9XFFaBesxLVQnhLJ9u6NevA/3UvbT42DwMRo3HC
         nKWjYs8hI93hYkslW4gFG4FBUOSa6STYMMZMPAjglPVrHvS4giZ92U0KMu7tmnQaOD49
         ZqRXAVwzfUU1/DvmR6u+vi8CNy9t/J3L2aGc3O/A7Powf9Z0BmjQiHkghTmHgE36HrpL
         rU+A==
X-Forwarded-Encrypted: i=1; AFNElJ9ZuYBbRHd8nfGxm2fxaBjYvk9wqzpQrKvztl8T7FReVnRA/UwLD2kGGTUUvLTvVrDP3lAnpCO6M9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX09amwBE9+i9BzmvAHDo3jDL9UM0Mbtkwt12oKMeaE4oOpmsZ
	QKc1HcsUb7y041mHIdYyzWL8yV0i8iK/lSjnRSUPKYR23FEKe6fRTxtVYJHfbNzzPD7nnhAl46f
	CUEYaACrBANVxhPgr+Q==
X-Received: from wmbz1.prod.google.com ([2002:a05:600c:c081:b0:490:af44:67a5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a016:b0:490:bc46:1a58 with SMTP id 5b1f17b1804b1-490bc461b57mr60168765e9.18.1780571861570;
 Thu, 04 Jun 2026 04:17:41 -0700 (PDT)
Date: Thu, 4 Jun 2026 11:17:40 +0000
In-Reply-To: <20260526-rate-exclusive-get-th1520-v1-2-34cf034e1764@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526-rate-exclusive-get-th1520-v1-0-34cf034e1764@mailbox.org> <20260526-rate-exclusive-get-th1520-v1-2-34cf034e1764@mailbox.org>
Message-ID: <aiFe1NSoQDs1YOj_@google.com>
Subject: Re: [PATCH 2/2] pwm: th1520: Lock clock rate with clk_rate_exclusive_get
From: Alice Ryhl <aliceryhl@google.com>
To: mhi@mailbox.org
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	"Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9256-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mhi@mailbox.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,garyguo.net,protonmail.com,umich.edu,redhat.com,samsung.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mailbox.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE0AF63F5BE

On Tue, May 26, 2026 at 07:04:58PM +0200, Maurice Hieronymus via B4 Relay wrote:
> From: Maurice Hieronymus <mhi@mailbox.org>
> 
> The driver derives period and duty cycle from the clock rate read at
> probe, so a later rate change would silently miscompute waveforms.
> Switch to the new ExclusiveClk wrapper to hold the rate for the lifetime
> of the driver data and drop the corresponding TODO.
> 
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

