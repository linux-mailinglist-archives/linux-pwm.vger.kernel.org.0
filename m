Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAEB49461D
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jan 2022 04:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358347AbiATD1H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jan 2022 22:27:07 -0500
Received: from atcsqr.andestech.com ([60.248.187.195]:23780 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358344AbiATD1E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jan 2022 22:27:04 -0500
X-Greylist: delayed 747 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Jan 2022 22:27:03 EST
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 20K3EZHg007169
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jan 2022 11:14:35 +0800 (GMT-8)
        (envelope-from ycliang@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 20K3EElU007118;
        Thu, 20 Jan 2022 11:14:14 +0800 (GMT-8)
        (envelope-from ycliang@andestech.com)
Received: from atcsi01 (10.0.15.167) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Thu, 20 Jan 2022 11:14:14 +0800
Date:   Thu, 20 Jan 2022 11:14:11 +0800
From:   Leo Liang <ycliang@andestech.com>
To:     <linux-pwm@vger.kernel.org>, <thierry.reding@gmail.com>
Subject: The data type of "period" in struct pwm_state is different from that
 of "period_ns" in struct pwm_ops
Message-ID: <20220120031411.GA978903@atcsi01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.13.2 (2019-12-18)
X-Originating-IP: [10.0.15.167]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 20K3EZHg007169
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi guys,

The data type of "period" member in struct pwm_state is "u64",
but the "period_ns" argument in struct pwm_ops for config operation is "int".

Should a patch be created to have consistent data type in case of an overflow ?
Or that is it the API users' responsibility to do the correct conversion ?

struct pwm_state {
	u64 period;						<<-------------
	u64 duty_cycle;					<<-------------
	enum pwm_polarity polarity;
	bool enabled;
	bool usage_power;
};


struct pwm_ops {
	...
	/* Only used by legacy drivers */
	int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
		      int duty_ns, int period_ns);							<<---------
	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
			    enum pwm_polarity polarity);
	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
};

Best regards,
Leo
