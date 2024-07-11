Return-Path: <linux-pwm+bounces-2772-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDD392F2BB
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 01:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA87B21124
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 23:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072051A08BA;
	Thu, 11 Jul 2024 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ThcWAICA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3916C879
	for <linux-pwm@vger.kernel.org>; Thu, 11 Jul 2024 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741581; cv=none; b=lhNdIUH9jJafTFNqmSd2L93qq8nQ7MQ1VczF4sDVSRMbO0Gb2vFdPJcO6ijtnpF7Mj+WvpZvJN2VbGzHRMkmwFsFlZngkSofD+1hDW6dGXR0yefEUs5cdZfCu/Rc9fI1tsGkQj4tx5aWI3vasKwBYeHKxNm3shGzrqTfBc0zGQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741581; c=relaxed/simple;
	bh=2lokm9uCl6o/abXtjtX/wmsJ5mYneFBL5sd2oqnz0PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrxrggvXaKr3mSn5RU1OKfnT+Dv5dr0Rd8xItiEZsnfFuj2DZfr63axT4V4r9w6zwL6AMgmBrBEE/xvy8MaZnPK5ftJkX25JiugECXufh5j9o+FgvZHwaZFeS5yvXof6Og1aXzmKQ8eVeIBiF7RNaA7yqzUNjLstYQ/Ell2AwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ThcWAICA; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7913D2C00BB;
	Fri, 12 Jul 2024 11:46:16 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720741576;
	bh=EKGPPthhjVJwEdnCORAyHfpXsGIZwcVoOJ6m2/X6BtA=;
	h=From:To:Cc:Subject:Date:From;
	b=ThcWAICAgwy575O78H9g8ZQevLUk4VqQnqxgYb9btjLsvjOZAI3gEBCy/DQ0pcmsO
	 +SSD6g417oVqUijXYoN5cD56ch724kse+Ptq5va6zdWEABf0oWtKKH8XQFoiUXCFzW
	 WP2WTYkRGctI/aIB1pxxo4vvWLWsIjqPWlYo5RtwROmSbUqMUHk+1WbUzS+bKioMtS
	 n+/bK7LmY1rHifK/HiqraqeGxgYeVAnuV8268+JxtqB2uYvajy9WOUKBfYL/0Mcy3A
	 01a4smN+xAipiYb0vUfortQIm+URivSDUd4KuNaMoGUcyqJXwv8tQNogh2VHCO3OVY
	 RSQAdsD9MWLMg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66906ec80000>; Fri, 12 Jul 2024 11:46:16 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 3C12013EE2B;
	Fri, 12 Jul 2024 11:46:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 36DDB28097C; Fri, 12 Jul 2024 11:46:16 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 0/3] hwmon: (adt7475) duty cycle configuration
Date: Fri, 12 Jul 2024 11:46:11 +1200
Message-ID: <20240711234614.3104839-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=PIKs+uqC c=1 sm=1 tr=0 ts=66906ec8 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=1vY5SClPdTbzMX9iZtUA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

I have a system that has very over spec'd fans so the amount of noise whe=
n they
run at 100% duty cycle is considerable. We have userspace monitoring tool=
s that
will configure appropriate fan control parameters but there is a bit of a=
 delay
between the kernel loading the driver and the userland tools catching up =
to
configure the fan control. This series adds device properties that allow =
the
PWM duty cycle to be specified via device properties so the PWM duty cycl=
e can
be reduced as soon as possible.

This series attempts to setup the adt7475 as a pwm provider so that we ca=
n
specify these properties. The devicetree support was reasonably straight
forward (example usage is in the binding patch). I struggled to get the A=
CPI
version working well and in the end the code had to distinguish between t=
he
of_node and other case. The ASL I've ended up with is

    Device (ADT0)
    {
        Name (_HID, "PRP0001")
        Name (_CRS, ResourceTemplate () {
            I2cSerialBusV2 (0x2E, ControllerInitiated,
                            100000, AddressingMode7Bit,
                            "^^CH00", 0x00,
                            ResourceConsumer, , Exclusive, )
        })
        Name (_DSD, Package () {
            ToUUID (UUID_DEVICE_PROPERTIES),
            Package () {
                Package () { "compatible", "adi,adt7476" },
                Package () { "#pwm-cells", 4 },
            },
        })
        Device (FAN0)
        {
            Name (_ADR, 0)
            Name (_DSD, Package () {
                ToUUID (UUID_DEVICE_PROPERTIES),
                Package () {
                    Package () { "pwms", Package () { 0, 44444, 1, 22222 =
} },
                }
            })
        }
        Device (FAN1)
        {
            Name (_ADR, 0)
            Name (_DSD, Package () {
                ToUUID (UUID_DEVICE_PROPERTIES),
                Package () {
                    Package () { "pwms", Package () { 2, 44444, 1, 22222 =
} },
                }
            })
        }
    }

If had to introduce a code path that parses that because try as I might I=
 could
not convince fwnode_property_get_reference_args() to fetch the informatio=
n out
of the ACPI data. If I've missed something obvious please let me know.

Chris Packham (3):
  dt-bindings: hwmon: Add adt7475 fan/pwm properties
  dt-bindings: hwmon: adt7475: Deprecate adi,pwm-active-state
  hwmon: (adt7475) Add support for configuring initial PWM state

 .../devicetree/bindings/hwmon/adt7475.yaml    |  37 +++++-
 drivers/hwmon/adt7475.c                       | 122 ++++++++++++++++++
 2 files changed, 157 insertions(+), 2 deletions(-)

--=20
2.45.2


