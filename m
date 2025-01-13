Return-Path: <linux-pwm+bounces-4585-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C3FA0B3AF
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38011881E2B
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D9235C1B;
	Mon, 13 Jan 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJvZSkOq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482113AD0;
	Mon, 13 Jan 2025 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762149; cv=none; b=UFMEhHsMOPhmfE/nkARnMUzIMXrjee/9GeW/SyokbwStqvnao+Fhsg6xqP6ggIqCQuhScDv+jYUBwW4QiAkz+Ogg9QWnTHlRkXqM+gpwk9IGTDa9VGeMQ6w4Ap67se/gz5HWnNg/Nyw5YDZ0VlfZGG0T3s6rngUjcxjgNBEwAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762149; c=relaxed/simple;
	bh=DMJLEDZzwVtW7PCUYJWT0J3CFxkZr+AvH3xIXYYXVIw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A0qixEH+y4rmlfZejmeB3odcNmSIWmmhKF80vD+MHZUjccmWEOtp1lCYPjiKlnJ7Mkmjbdfsfuq3OfY461T9uiAhbl9GraXomut+7ehWW9MtlLXckAOxcI/G5lkJZYsZuirLfXX/qyUn8N5VXoF7bg6kRR5GiuLbrZAsKmcmR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJvZSkOq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43634b570c1so28661375e9.0;
        Mon, 13 Jan 2025 01:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736762146; x=1737366946; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DMJLEDZzwVtW7PCUYJWT0J3CFxkZr+AvH3xIXYYXVIw=;
        b=GJvZSkOqvJc/kkZotQnVJlTBUL3p5IMPSQI4kdDzjc6a1hSWEe54ZwLYMSt9Obl20P
         jMhljZSAPZfEOMLvCyjOuklyRsa3iqNAefG0z7/g3Ar5Oe82Wp+UOdEcY3echo2hRZKg
         ljTmx1bZ6/RFwK32Rh8C1RA892i8zGQkZbdcJjtBPrM1Bh93je/ojFL5MO/P4yZlmCuy
         UUDEPImGUClWRv6YsBfCPjwZXfOcz7bEXQIv25oZe5e0RXZqfQsJqgfnszZYQ3wkr/Nz
         3QW4EG/kvPDDkQc5ixZxasGGL+LA8g3Hgfgi4/t8q2VpaEmreLr2Wlxmnls9yUoqF/qv
         Hw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762146; x=1737366946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DMJLEDZzwVtW7PCUYJWT0J3CFxkZr+AvH3xIXYYXVIw=;
        b=vdlYSVu3v+rwV9Er3y35SbBzFVV4nK2cWAJ3/k2LWev5sd0/4oJohpGPLCcz/iUgsW
         +x2yshMJSrmZRhooWg4VCNXXHS77a1ywFJMW/kMsr3mBWj11d6lEI/5ZRwa/AqIP4jKV
         hQrKbCI8v3HHr7qxfEolvB/V2kkE4SrVTRwcGFxlyYYFjMSWFl4S2vT9s/TFT648TjQw
         f23w+HGdMp+0/AJfgayeeV2GoS1s/zAfHioejtI4Ot3AqnjDOnmGvqKGnTbyHlWupWGU
         Hdm2fUbm+MS4zB6tF6X91xOMdw1tHYgcOUQPQyx+4Xvb1kJY4ABuC9yHRrYx4XdAO8w5
         PRHA==
X-Forwarded-Encrypted: i=1; AJvYcCUqeZas74m8+3IK7FqzhhjKFNLt02Wqz9IfGhxM4+0LPU+NOPBTe9I/KI8bsgIb4V4HQ1tc52YGZi+k@vger.kernel.org, AJvYcCUwtLdHBMPbOYCOx9qF8AqKYr7hQz9Vdu75s17g6OP+7noygjQk6b6Vq1qBerjlUAnCilY+elXRTmLj@vger.kernel.org, AJvYcCWnyyzQyx1Z0tIa7Kmd/SKiEk9QK/xL5sYoZc5L6XCoNAppIA7QbVjpbPMO+I1BkFlZbygWjiG0W9tdgAmt@vger.kernel.org, AJvYcCX09SkzZoGZaVeZt9/9D10gyKRSG7QUbjoK6cZXCLVK/J1iusYkjwB+nd81tTUKTUkfM+8uKSbsvI+X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ThkI0ips+klrZNCzUYJyG65jhgaaLBrjxerimLuloDV3Z7gu
	9LHAKqa6pK8uuvty0MSXd/3GxHTHmz0Sdba9f/aGrOllZKbs1iHbHHsLzodSOXA=
X-Gm-Gg: ASbGncs+DKfuso5e+NhiLOUaYDuyt4vbTg9Zq3L7UBtgHN4yQ7OBBjRTNSK8Uk8kSyV
	su1ibZCbDp85kJMRHKqrB+idsIlQ7t7LLEZS+Q+iNqXd+PHyqP2tF/sihYuR0xk/Gti7iymZ14a
	+iqWRUVDlHb8BXrgOpUuZvTORkczVUfzGk0jxDQ1Zs9ALKjfi5Lg34qNnH4gpyxpFhBlogLkWAa
	M5iFGpGoZMunJFai0VLKVorRzhStSSbWu540TgMlHCJoPoB7Lr5AlDYjRP32KV9k6SjP+EHmczN
	LjGwLgzlDmjjJL7BxpsT5UtnGF8q
X-Google-Smtp-Source: AGHT+IExYvHyvyRoskOPeTjs9kkzT6Y1YgcdXNgNm20BQFw2OvMBlzTReHNefbalEay/cULokY+FyQ==
X-Received: by 2002:a05:600c:4fc2:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-436e26803f4mr172086495e9.3.1736762145595;
        Mon, 13 Jan 2025 01:55:45 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d17dsm11495410f8f.21.2025.01.13.01.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:55:45 -0800 (PST)
Message-ID: <2f483161cbe1f797a9095ca3c9f4f472d3785acb.camel@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adf4371: add refin mode
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Mon, 13 Jan 2025 09:55:45 +0000
In-Reply-To: <mr7j4znl63p3ldhrxpc47mio63deszpqswbsqxxiby5nftpgbr@b4h47yp3xev5>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
	 <20250109133707.3845-2-antoniu.miclaus@analog.com>
	 <mr7j4znl63p3ldhrxpc47mio63deszpqswbsqxxiby5nftpgbr@b4h47yp3xev5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-13 at 09:37 +0100, Krzysztof Kozlowski wrote:
> On Thu, Jan 09, 2025 at 03:37:05PM +0200, Antoniu Miclaus wrote:
> > =C2=A0=C2=A0 clock-names:
> > =C2=A0=C2=A0=C2=A0=C2=A0 description:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Must be "clkin"
> > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Must be "clkin" if the input reference =
is single ended or "clkin-
> > diff"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if the input reference is differential.=
 By default single ended input
> > is
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 applied.
> > +=C2=A0=C2=A0=C2=A0 enum: [clkin, clkin-diff]
> > +=C2=A0=C2=A0=C2=A0 default: clkin
>=20
> Which pins are these? I went through adf4371 datasheet and no reference
> on clock inputs like clkin or clkin-diff.
>=20
>=20

Hmm, I guess we should call this 'refp' and 'refp-n' then (the latter seems=
 a
bit more odd)? Or just 'ref' and 'ref-diff'?

- Nuno S=C3=A1


