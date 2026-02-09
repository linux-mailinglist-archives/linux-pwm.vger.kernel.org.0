Return-Path: <linux-pwm+bounces-8108-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCu9NgjbiWlFCgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8108-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 14:03:04 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEAD10F5FD
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 14:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C073C300A8C1
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Feb 2026 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158E02459DD;
	Mon,  9 Feb 2026 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU7S8d3G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D5A23EAB2
	for <linux-pwm@vger.kernel.org>; Mon,  9 Feb 2026 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642175; cv=pass; b=kXCPtYlvWxpNPwUhlk4LHYWESvXwAo0on3PsAvhqnWzktQ8u5D21XpA8NOPBKKPXLywz92MYJY3UEz8RZO76jW3zK8xPuEGBXyTyJWKG/N5uglH+SQDkIJWoTZawYYxmyQaEaZxiNYFZkbWCiEhOBTTtNqAyRaXQE5scT8c5cxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642175; c=relaxed/simple;
	bh=9B/UCgO1tyVkfJRuYxeUewthRi8id8Vcztdl2EPgKj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A694FOt3tchYSHIPdX+ZorHbj++MbOvdGx0aOYWfratQjr1cJD84FucW0kGw/gjU5rSjSKKI4CheLm8vQMyrcbWoPCa4ej17gC3z6V/YLGSt/2J7didDZDMu1N77u0Kr3JR9xJs0G5PcpCWCu4Mwfezx+vPY5YHOvMCaj9T6kaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU7S8d3G; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba6737fafbso40441eec.3
        for <linux-pwm@vger.kernel.org>; Mon, 09 Feb 2026 05:02:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770642174; cv=none;
        d=google.com; s=arc-20240605;
        b=XG40NQwyJD9PkjzIfZQzB6GFc+dQoiiuY/Cjot/3Pc4RIQr7ycf7+RId4AoCWaodzS
         RbXul281SQOLkMJudX5lzYWYgPEw7JiqXUtC87FsF6OJNjLWxL1/lPeuOjj24wLLvfQt
         Ha6Zhk8fyjGZAPi70TCxj4KXKKeuwvy85MQi1g6K5vkCTQAN5wutWinQsmSl3fra7gdD
         t9MRZwXLmhNNGCGPPCsyCloalF4hw0WtGw/hOU72gcbMeSX3xOeqvAbGqlvH9pZOZuZh
         q/JyrU948+Ng7r6Jfes/ekr21xZqNOV++ml7PmfDlUEgGh+5vbbxZ78HCWSq36PnTWXi
         IBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=khoFsSTVz4b1i11FJkTbeTmQEtUujLgmVbgw/XgwjGg=;
        fh=WCn5p4X/2IyQXjZ5kUzAxP2AoEsWkTsp3NbWClA1crw=;
        b=cfvmlOF+370mL/SJO1SwdqJpI9we7debOdCWODIq025XKb/rkfu3SEINU1bc2feV/w
         rL2gco3s2cw5liPZzOrWcRHvTemsr8EpF8JMmAqvwWnws9Csa/d+uOdyp2ywcopa1GyE
         1raLogbHuly5p1FeT6+tqY7Vh//KYmZFdZd0wsuwy5YBaF7qpWrEagrk1lGMkjnQkiNw
         B3C8YInLt57h/Dh6ojFf7bsp0dm2Pp0+x7XAmQpQ4rhCoRQCNlCAdMqNcAnFFe887pJw
         80OveHv8iYzJ/K+0gsku4f/sFXy7IBxb+v+yqihgyIwEtvTruGnjN3xwQJm9QGxd9tGu
         KDPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770642174; x=1771246974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khoFsSTVz4b1i11FJkTbeTmQEtUujLgmVbgw/XgwjGg=;
        b=UU7S8d3GFNEtRb8AJRM6x+qWF8Y8uvIynzbi/MilP42OHszQQAChNUs4gvF5K07YOO
         DjUOXvYHv/azDeY/Ju24bWlggsEsXTml9Z4MEXnSD1C57nEA0t5UFQQHHqY2seySK05D
         QHyEOKztpvyS5/VpAwO8XoLLpAxqAIYVPi4DDUuwuado0mZ9OyPtuhYyk6XJ3Icq+iU+
         fNJ629Z3GmqdgvjUbsJPcqhO7OnZFiFU6PyfRHgLOaLV46Vb/ziZ/bII+RUQaoblxI4f
         2yLe5bka3vA0d27E1gd7PcVY3gOJ+EDmRRm4AnsSPwbvvbVxfDkhnTrd/E2dhySVQvf3
         206g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770642174; x=1771246974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=khoFsSTVz4b1i11FJkTbeTmQEtUujLgmVbgw/XgwjGg=;
        b=HOUNMaHKjKTs5cKDhIBog7zeYzz4nWSryVm9kJrpekGoJDWOSN4Oyfq7BAzDWZ658c
         jQtFKj/HzfV2O35SH0/Dq0oSq0k4weDXZq5vPX8C1FMKEn6taNeUYpvBAYDrenhQrYSr
         jq5Z6XGDUeSdoFJzepcXv/BOqYJTGQ99dsfgemf6Mw4Pi3LQpx8D8TAPheLhB5PB3Noc
         j/pY0pFh38mBACSYMK0vZzWeehUPhv4GIlXqiSw8ofj6r6F/gplv6PKxvQnjWlvfmCwQ
         IYiG2G7p5/7nljSyrBIpU4CV/+wtYTH7JLLnCvSxLNkDjf0jrno4MbecszO2Qxy+e9s6
         YVDA==
X-Forwarded-Encrypted: i=1; AJvYcCXnCxAv5KA271kTKaR/gukFeq9w98ifSDowVqpV0FaUZvARHQ/yg4OpKUQB5UEqaedGPOg8IOKqUjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyysXscaljDTy2rgE7UIbXYwzrJr0RzFGzJHTIEtWr+2G4C/ym7
	DKxWNHby1sDsdL73cGmNNPmCsAReNSrRAgDKpw2RM5ly8nFS3eyxz65iilSC976ex0OlJwzASOW
	BTH2ZI4TLq7QF9KSQDT/K3VEnTOGSwJo=
X-Gm-Gg: AZuq6aIo+vphzp52VC59l98pYEV2Hr/3jbscZM6YjyduWCUnfWe0JI6VHQXCaSu/9n0
	dgMKjTpjdTXDbmrfJdDH1P0ek3MVfbYVuRCM1iEBd1Xu8BTB7ks1RnKl5os+rsTv8g4pbEYVtLu
	HXraX4Xq+UDhcSLAqts0bnI9YlUbYL7rqXD2MMtwQwAUtadVnDqHUrpIYOwD2lSbvmFdFuLzTq/
	BgqhUJ837OhPEaAvpo52nTlosENyv901oK8TxXmkEqdVuDSR2Up7OWF5SblYTbUkWwh/JlbiKmN
	+l+JxghxUBf/V2iEMMOzg5vDxIa1HksjVPHOQ7YKokpZV+GSPmGWwb+Jn2v56iDE0NcbOr1oc5j
	Fr7vcFDiDWYFT
X-Received: by 2002:a05:7300:e607:b0:2ba:75f5:72cd with SMTP id
 5a478bee46e88-2ba75f5830fmr502025eec.9.1770642173699; Mon, 09 Feb 2026
 05:02:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121183719.71659-1-ojeda@kernel.org> <aYmgjEWaLrdsubKM@monoceros>
In-Reply-To: <aYmgjEWaLrdsubKM@monoceros>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Feb 2026 14:02:41 +0100
X-Gm-Features: AZwV_QiSCxvsBPMPbdvLVQ6n5PFjHBckpVSND2cAYzso4jDes2NZlheZfkl0_H0
Message-ID: <CANiq72mMS2EeU9ayDpm+xCz3xQyRBgRyWW8KKvJLAuCC64Xi3g@mail.gmail.com>
Subject: Re: [PATCH] pwm: th1520: fix `CLIPPY=1` warning
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	linux-riscv@lists.infradead.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8108-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,redhat.com,lists.infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3FEAD10F5FD
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 9:56=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Looks good to me. I'll wait for Michal to add his blessing and then when
> picking it up tend to drop the Fixes line. Or do we also care about
> CLIPPY-cleanness in stable?

Yeah, so far we do. At least, back then we decided we would try our
best to keep them clean, and I build the stable and LTS kernels with
Clippy enabled (and I think some downstream users may do development
based on those, so I hope that effort helps).

Worst case, we can always drop that requirement.

In any case, some of these patches, even if not considered Fixes (e.g.
a new lint), sometimes they may need to go "urgently" into `-fixes`
branches rather than `-next` ones, i.e. even without such a tag; and
we can also still send them to stable -- what I usually give the
stable team is a line like:

    Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is
pinned in older LTSs).

I hope that helps!

Cheers,
Miguel

