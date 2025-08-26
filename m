Return-Path: <linux-pwm+bounces-7166-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCF8B3527A
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Aug 2025 06:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E961D7A6C48
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Aug 2025 04:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C53238179;
	Tue, 26 Aug 2025 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4lRd6Hn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B163D984;
	Tue, 26 Aug 2025 04:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756181151; cv=none; b=My+5D3Lx7vSg14ZsDc16FO52F3TQZQ0wrp0rNAyidoYGEdeOZ65VKvYD2ptdP0jIu9ddJpRQiupkZiYGECWYUwcSKzgP3m3oOEwv7jV0Uwm2Ev64B+a55QZEH3FER5dwWXc3XxElGkJs3u9EmQqM4i93XicZ37QeODCWpHYIy/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756181151; c=relaxed/simple;
	bh=tQmrhQgBB8tU5aHIXx0GEZbzlpaY+o7P4deToltHdG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpbW7msplVexwV2bVEl728V1a3+HqhjyscDq8h/dr5Xf6X9ANMhAKg5F8/5wNK3AfmWaHgksvWkR3Ja0J7Jh4UfYAcEsHJH2FTPoS7+9esjXt1PJTIQj6WP/mgWPnes5RRXEo2RAAta2+gnJ1WMpwtBgv2jGZKYqyy1/J1vqKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4lRd6Hn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32597b88f0dso1579918a91.3;
        Mon, 25 Aug 2025 21:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756181149; x=1756785949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQmrhQgBB8tU5aHIXx0GEZbzlpaY+o7P4deToltHdG8=;
        b=O4lRd6HnOK2FqKlakR2Di5X1UmSQyrVFGuVL3VTJKY20VoozC0BFFtxmKhpf4nDruF
         7IbuOueQhoo0mHUjpnaGxgjBr5jUBeXfpaPZEQ0F5OYXtgf3Hwr1Nqf66CiRxP7tmbXz
         ywnbVSb99h2GW1nWi8YjgCwhn/rVjQWgvspsM1StYoTQsSlBw+0SdAOaE0JsDmCMxZai
         74sf/bd8c4iVK16vhdZogG2Iv5qop+YzUnJryzM2x6Q43nkxCkuktWtZzqWNn6JrUBV2
         LZn6atA1Pr4hCbbPXgRgBqktAbjh6hsLm+IfNN62HMrHvmEPHdJijD5eY8wkFCMmWoIG
         SNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756181149; x=1756785949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQmrhQgBB8tU5aHIXx0GEZbzlpaY+o7P4deToltHdG8=;
        b=px4yTLKg6aK7AuaTNzz1QxlFK1b2zrzlUM6vcIaXlRmSMzK5h4Iz2ACKjX8jPkU36R
         GXQRfG+4ked9EhvO8Tyno/pptPmdd4VoVuz2UQWjjQ3FjfT8dAmKkSTm3Yo4FILPdzVD
         JkUt1CdGH+xRmzxuMG4e0OKjApoyyiDs/INpZp1NvW3ELbKmqWAW9grVuoSJ1LsKKLU9
         U1ptzaIgjDsBBFZ1Tkgf9bH60I2LADpZAC8EbK+fVF+AJvz5WrAefLzaZpIFzYoWg/Lg
         Il90Wa7ziX6nsPINDpg0Zx5bKyyZfE9n8NTaQ/Y/HuT11AWZr35whsYJRE/v7Hs+dJEa
         42Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWBiKHRQWZretvSmgYqhcZvOJzSIqP9MuqynGEPBLloIDoqyviicS2qAbbQ4sJ8tFnPbSgJxVnbzqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgwjnNo21CdZv8r6mozOy/ZxXOirjWsrqYqSmeS9bn66m/JB7
	UGzqqQ5GQ6xFvji0QTrWp/EK20MXyvp9Lpoq0vXdhZ4gbepY6St13IgM
X-Gm-Gg: ASbGncts29nd+i7XVAN6VgYC9QfH/TmV97AoveCiNk5nNET7xjX9MuNEi39Losd88YF
	cz/cLW8SZjKSIggUoe0S1eqe7tLSlsAKk1XMPH10AAeoUP45VFyRcbrPD/GxehDlXc3CAKzpeFu
	Fd2fFiRIX0o9LH8qZ0Baku+a5KWVlrkAAQWbDo3JvdPMYAv37N3z+gojEWlFcz5Jc639S9TpmRA
	RZIZEF2iNUJ+BsgzsJ89smvkW2giz0FT+efXlZqD9fxQmiUync+75Vj9WbVbJjXFRky0SIYRs0G
	yzCqcwscHWz8KQMJixl8GeyYuMYJLsMhjGy6jzCxGOHcFyjWr+yrIuk4RDlXqH3Ih1AUmvGBXt3
	asL6w0NMdl3zziUwgVwf8xseXsLmHJr0tZRbn0qMoRHVzMPA=
X-Google-Smtp-Source: AGHT+IFk0pcdm2dvEhgmC8S/XkLFNjKnZFN2UwQ4JCBRRGEDQNvPyX7xmhEQw5DwXyrtD/zW6zb3og==
X-Received: by 2002:a17:90b:58cb:b0:321:6ac:532b with SMTP id 98e67ed59e1d1-32517b2cfb3mr18347478a91.35.1756181148834;
        Mon, 25 Aug 2025 21:05:48 -0700 (PDT)
Received: from paradiselost.local (lohr.com.br. [187.58.145.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3274d85dfccsm248523a91.23.2025.08.25.21.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 21:05:47 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: Re: [PATCH v5 1/6] pwm: tiehrpwm: use GENMASK()/FIELD_PREP() for register fields
Date: Tue, 26 Aug 2025 01:05:07 -0300
Message-ID: <20250826040507.3160-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dithxhozx4k6n6xu7qrunsxec2wrklj2fipp3r24tlunmj7zid@vgqvfjw7onld>
References: <dithxhozx4k6n6xu7qrunsxec2wrklj2fipp3r24tlunmj7zid@vgqvfjw7onld>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Uwe,=0D
=0D
On Mon, Aug 25, 2025 at 10:27:26AM +0200, Uwe Kleine-K=C3=B6nig wrote:=0D
> There is another series touching this driver at=0D
> https://lore.kernel.org/linux-pwm/cover.1754927682.git.u.kleine-koenig@ba=
ylibre.com/=0D
> that would be great to get some testing and that I tend to apply first=0D
> given that it contains also fixes. I guess you didn't base your series=0D
> on top of that?=0D
=0D
You're right, I didn=E2=80=99t base my series on top of that one.=0D
I=E2=80=99ll test your series and can rebase mine afterwards once it lands,=
=0D
so we avoid conflicts.=0D
=0D
Thanks for pointing this out.=0D
=0D
Best regards,=0D
Rafael=

