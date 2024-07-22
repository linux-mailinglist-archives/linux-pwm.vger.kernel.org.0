Return-Path: <linux-pwm+bounces-2880-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F52C938724
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 03:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914F01C20C64
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 01:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0B610C;
	Mon, 22 Jul 2024 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="aX0Zew5+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE064C7D
	for <linux-pwm@vger.kernel.org>; Mon, 22 Jul 2024 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610519; cv=none; b=WS8ZmuC2LOuuTm4tFMTng7tUz2/PGoG7TdtdzGRIgs3gzMYhAUBvu2/xmGeeYDtFCT/tFmTZzQA9cjZMq4lVLyIbRcL0rponr1SjlzuOsT6OFn0cSjtUTMjsrWvKX5GSRyEdoFltR3Lx8h9vflCRukcfZDAqA3Ol/+cpTKFoVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610519; c=relaxed/simple;
	bh=LQGGwmtPQi83POL6jKJzd0CjYqPPGixiEWajpJj6uAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDpKronOlbhAO3t94hhaoLFNpwFyLPXzy0q3LnSI10n4cL7JQ/knHuzjDgEQkUKs7jWYkkkVJE04ah/X5jztX14iyx4vVv2IOeEecd5lB1aQ8M7vu7y0t2UPVnW5YnqTITW/7GG7a6LYf2fPtlPF/DV7ceyOkXHdGzhHGueHnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=aX0Zew5+; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 637C32C0D4E;
	Mon, 22 Jul 2024 12:58:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1721609921;
	bh=WfH33PLAldYMJ+pDXxUw1Ptq8AZh9K0ykjWg0OEjoPI=;
	h=From:To:Cc:Subject:Date:From;
	b=aX0Zew5+S4dJiKNyg55TtCyZwLmnjLafQnBufLfeR4DZ4o1XKeV0YP1uivW5kIl6P
	 jHRIepWNwuALy7vRKLeNElDmZb33fzA7bKRBDkKNJfkhNx1iHbOIELO82V2IgS1LQQ
	 3obVG1hfntMSkw5UTQ4yW/wCsRFekXrI+H/I/TSoqW9kKS3sSyqSwojfkhnK7PKJ1r
	 TDayatyONOZJ+yog7CjJLo+0/orq1XKamWXX7QMpGSAUngVnqlod6FhIQE70bafC9L
	 9QCflE1alt9jwoHN00crjBNKt92PsK/iBWuQakJ/1VwH8ihAdrnNvMbDAm15TuK//j
	 ShGiGNtgL2Jog==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B669daec10000>; Mon, 22 Jul 2024 12:58:41 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 3649813ED2A;
	Mon, 22 Jul 2024 12:58:41 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 31C3328095E; Mon, 22 Jul 2024 12:58:41 +1200 (NZST)
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
Subject: [PATCH v6 0/3] hwmon: (adt7475) duty cycle configuration
Date: Mon, 22 Jul 2024 12:58:22 +1200
Message-ID: <20240722005825.1800403-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gqbh+V1C c=1 sm=1 tr=0 ts=669daec1 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=1vY5SClPdTbzMX9iZtUA:9 a=3ZKOabzyN94A:10
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

 .../devicetree/bindings/hwmon/adt7475.yaml    |  37 ++++-
 drivers/hwmon/adt7475.c                       | 130 ++++++++++++++++++
 2 files changed, 165 insertions(+), 2 deletions(-)

--=20
2.45.2


