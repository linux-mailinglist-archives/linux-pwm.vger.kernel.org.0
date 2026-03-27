Return-Path: <linux-pwm+bounces-8393-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEHKEnGmxmk4NQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8393-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 16:46:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9B346F85
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 16:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3C683074AFD
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB6330B2D;
	Fri, 27 Mar 2026 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOBZ6IJg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF41331A6E;
	Fri, 27 Mar 2026 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626172; cv=none; b=OJ6Dc19me2EQ5dpWpmWkUYKdaOXlthmOI1NNyD7/4wS2g5Aecv/JmO6YEN8j6N5MYxzRaJtxifbH4uEj9x4pwF2dB38hY39Ou5Nok3ghRG4uhUc7lfQA2/FxDGM25lJtgvY92ALnezvnKqp2SxTfDkaYpT8HioexrHrApeSct/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626172; c=relaxed/simple;
	bh=N5QspxPejw9w7zUpfqwNJA5lxWidOkYMOUOW5hyNY4o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=O5iNjoICbn2g2j/IrmeLFMImUqkPjApSxBGvZ4lAnmiMexEb+CsWhBABLvdNR2FA8ZYntx3LijO+EMoNsuzIl6LtGlFaez1mQgWYVFIzr8aWVyOXpRV9ZzHDWt8YalgcKDFJJV7cmEisnbN68+TZX2jPgHaJOGfndcKOKbatN3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOBZ6IJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AEDC19423;
	Fri, 27 Mar 2026 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774626171;
	bh=N5QspxPejw9w7zUpfqwNJA5lxWidOkYMOUOW5hyNY4o=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=sOBZ6IJgRdrDctxoaRi9B4+iVWwtU8840GbGAX2CiFIFvRyghghoZqzAvmBqnDYza
	 nZUsXT0OkOdN2YAvgAf5Xpwy7K0EHAR6wn/yr/Q1IamnDB3Bgjn1198pUj6FEJenGg
	 rhu2EPCmAwKg1mcsC8H7nl6WAWB4mOYhAc2Otu2bgexuMOyupuFmQRAjal5sYDeAtc
	 0up4UCvSb2SJNM7ainpxfFQfMnVCeZVIgSbNnj9FongxWa5+0NJrGFN6sjHLjVDPD9
	 lhkXEwQu31BAAjjTuu4Z/zxqE5aIsb3+LTZqLsQD2qj81A+OvPXPlTvnrkhap1KMEZ
	 aojhI5ZJRtvNQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 16:42:44 +0100
Message-Id: <DHDOH1FXTIZT.1QKZIPZ73YNLI@kernel.org>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Michael Turquette" <mturquette@baylibre.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Drew Fustini"
 <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 <linux-clk@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>
To: "Brian Masney" <bmasney@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
 <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
In-Reply-To: <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8393-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,baylibre.com,linux.intel.com,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFC9B346F85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri Mar 27, 2026 at 4:17 PM CET, Brian Masney wrote:
> I am not a clk maintainer, so I can't leave an Acked-by for you to
> pick this up unfortunately. I've been quite active in the clk
> subsystem though the last 6 months or so.

I'm not involved in the CLK subsystem, but maybe it would be a good chance =
to
offer stepping up as co-maintainer (also given that Michael seems to be ina=
ctive
for a couple of years now). :)

