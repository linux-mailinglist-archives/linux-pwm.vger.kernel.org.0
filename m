Return-Path: <linux-pwm+bounces-7969-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEEhGvS5b2kOMQAAu9opvQ
	(envelope-from <linux-pwm+bounces-7969-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:23:00 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E99487AB
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DBC038DA89
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECDE320A00;
	Tue, 20 Jan 2026 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THSDmi8g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26E320382
	for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925795; cv=none; b=FfkJOzg9qPz72Gxr7j+CMar+PCd+UX6MR7Aw7FrRvMGmIXc6QQQKqiU1IPJWtVGlOZ3ebxiijaZ+mHMWfTH8Qm6rVULJHw+8EmmYxNlS1lZo9RcyA2zon9gKHOY4NuSJqSZapIrOBLQENMGCv89UVfLlZP5JeUS4oZxFIo8I9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925795; c=relaxed/simple;
	bh=BNzsItdhwN4AlCLoipqscYZCx4sHqbuRLNDIVXpilSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MY9AF5tMHbgGOw+//UKt5Z45Lk2E7T4yaqvhcO4T9vCc/t6U7P4LgoFH7Gu9HJUIRBC0mGBeIaQWnE4+K3aVhztAkP7uqldvykIudF23BCYD3XY9ufyCW62QP5OjoZQ6XgkZOczZmmEh8XehzL/ShGU+WVW/M/1T/5qaQZzYPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THSDmi8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97848C2BCB8
	for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768925794;
	bh=BNzsItdhwN4AlCLoipqscYZCx4sHqbuRLNDIVXpilSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=THSDmi8gq235TCymdcD40neouylxEUPybAk8IqPK1VlC9tfnkSczzfK6vsoo+M7vm
	 eXRPBc7IzwbOSPtHHf8dHvyl+qHLHU4MtJpcRy0md+yhVkI3QX0Wf9ZYLfVQc5BSI1
	 EpHa3DG6ExQiIEki+f+ELIQVkMORCQqN0OFyLZu1xmbWwpQIqrBaWzxjzqxN3FzfI0
	 wzaQ9R0CufxLLJ2C+ysHLBMxD0wT9LjUP0aUYVKk5p9C2c3t3djt/tuO+lpqqgq+dD
	 c1KckqjyOcvQbx+YLaC0JIE7KedRkmAOFwWC8fFgTA0UlhvXaSSwSGeNAhlnSKX2WG
	 hQVTvJWeGqqpA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-382fea4a160so53345821fa.2
        for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 08:16:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVq3Cnqnk8/c1Y6aPLNbCKL/eGIYW1iJAJsCrVLkWY5MVZONjbJYT/yKROB9erjXLnXtMbPSU+RyCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7mT619ootoPoB6VMHsFoCzzg0KmtL5+nG79HNbw67DiV/rVr
	drABVUGDVzFiewTmqkfCBqg2usWBYVIuWHqGiQMJBt9YKMP33ewg75W/FcwiQ7xVU4KLyb1RuLw
	26pwReyRv3vNfrTKMEsQqIw6fvo+PwbM=
X-Received: by 2002:a05:651c:3612:b0:378:d5dc:17c2 with SMTP id
 38308e7fff4ca-3838417c912mr56935201fa.11.1768925793031; Tue, 20 Jan 2026
 08:16:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com> <o4uvwymm73wnehs5zb7lqgv3mjv235jpprfqrsb6oxscxhmmjh@25u7wrb7yo2i>
In-Reply-To: <o4uvwymm73wnehs5zb7lqgv3mjv235jpprfqrsb6oxscxhmmjh@25u7wrb7yo2i>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 20 Jan 2026 11:15:56 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9=USrGECVS1qMqs+iCKUqvOdfcjA6phAjaF0wfcTkQt_g@mail.gmail.com>
X-Gm-Features: AZwV_QhGR5x54f9_gIkwS8dqtjPRJRBl1YkXPqMFOsqu-3oh6YnupyEAn_EqRwc
Message-ID: <CAJ-ks9=USrGECVS1qMqs+iCKUqvOdfcjA6phAjaF0wfcTkQt_g@mail.gmail.com>
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,lists.infradead.org,vger.kernel.org,samsung.com];
	TAGGED_FROM(0.00)[bounces-7969-lists,linux-pwm=lfdr.de];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 23E99487AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 3:39=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> Hello,
>
> On Mon, Dec 22, 2025 at 01:24:46PM +0100, Tamir Duberstein wrote:
> > From: Tamir Duberstein <tamird@gmail.com>
> >
> > C-String literals were added in Rust 1.77. Replace instances of
> > `kernel::c_str!` with C-String literals where possible.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Applied to
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.gi=
t pwm/for-next
>
> as merge window material with the R-b tags by Michal Wilczynski and
> Daniel Almeida.
>
> (Side note, b4 told me:
>
>           =E2=9C=97 No key: openssh/tamird@gmail.com
>
> . It's not clear to me how to verify this signature. My experiments
> include:
>
>         $ b4 kr --show-keys 20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com
>         ---
>         No keys found in the thread.
>
> and looking at
> https://lore.kernel.org/linux-pwm/20251222-cstr-pwm-v1-1-e8916d976f8d@gma=
il.com/raw
> where I see
>
>         X-Developer-Key: i=3Dtamird@gmail.com; a=3Dopenssh; fpr=3DSHA256:=
264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc
>
> which IIUC isn't enough to verify the next mail signed with the same
> key. Am I missing something? I very appreciate signing your work, but if
> there is no way for me (or anyone else) to verify it, there is no gain.)

Yep, you are right to call this out. My usual setup uses SSH keys for
commit signing, which are not part of the kernel web of trust. I
promise to start signing kernel work with my GPG key soon :)

In the meantime if you trust Github you can verify my signature
against https://github.com/tamird.keys.

Cheers.
Tamir

