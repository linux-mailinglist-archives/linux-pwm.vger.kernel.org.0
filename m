Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4A841416A
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Sep 2021 07:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhIVF64 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 22 Sep 2021 01:58:56 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:24502 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhIVF6z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Sep 2021 01:58:55 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18M5a389088176;
        Wed, 22 Sep 2021 13:36:03 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Sep
 2021 13:56:21 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <akinobu.mita@gmail.com>
CC:     <b.zolnierkie@samsung.com>, <kamil@wypas.org>,
        <linux-hwmon@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux@roeck-us.net>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v2] hwmon: (pwm-fan) stop fan on shutdown
Date:   Wed, 22 Sep 2021 13:56:23 +0800
Message-ID: <20210922055624.17883-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1579534344-11694-1-git-send-email-akinobu.mita@gmail.com>
References: <1579534344-11694-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18M5a389088176
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Akinobu,

Can you add optional properties to switch the behavior?
For the use case below, the pwm fan should not stop when the device is
shutdown by the system reboot. Our platform is BMC that will use a PWM-FAN
driver to control the fan on the managed host. In our case, we do not want
to stop the fan when the BMC is reboot, which may cause the temperature of
the managed host not to be lowered.
