Return-Path: <linux-pwm+bounces-1603-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1310E85E1AB
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9414B1F25417
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B11C80BE0;
	Wed, 21 Feb 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1M/w+Loc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ig4Tccdp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1M/w+Loc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ig4Tccdp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19EE80629;
	Wed, 21 Feb 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530297; cv=none; b=uRwAaUF3uKLXymND8lgSGhsRbxz8LmtkFWPyQgmnOILYRoxZAWJbGI607+IsW2LcSArESDO8ZAsbPTjHzt2ZYW4SpQNc21xjs9M0CIEUeWGlY4iyrA3+7qtgUHhK0BG8Tb9UoThAd7Om7lTFBMLRUf8hRK08bgPcB1QvEjdQEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530297; c=relaxed/simple;
	bh=dJGEQBc9u60scyuEJ1yhyoGYUlZRXNUr4yhm+wdFWLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utdTn2kWOXEOmSGkodB33TNTg8wViguqgu0TFBUywaTAefmAz7yyR+WOOl707wDwVcxHXuUgzq7dGNrkt5nGsise5UcEn5dIti7uFDlRaZcl/Pr3gWZP0/NjBbDQpx8cumu7c+chvbtbPGkxvD3dV7qHdDQqqBwleMYNBKpjUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1M/w+Loc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ig4Tccdp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1M/w+Loc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ig4Tccdp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6D3A1FB61;
	Wed, 21 Feb 2024 15:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708530293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wUbFq/UapptHuceSM9cs9GaCXgjIWCUQFz0kdXIi4EM=;
	b=1M/w+LocWHVmoByrIQ7QzLhtCc50ZE21bHrfbulpUcHQCwdfbEAJysA7CPKCqLDkOVe0pz
	EFQSATuitvfZmhVvdE2gh31CvVuTzqYbFUPnuFkpkuJ8QqW+RyI2gDnYuuSuLYTtFDcYFK
	WVqKSDNcRD/YcTlL/HN1vPGA5IE2qgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708530293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wUbFq/UapptHuceSM9cs9GaCXgjIWCUQFz0kdXIi4EM=;
	b=Ig4Tccdp4bt0ny2+g4VL4z+rLVx37TQydIbolqA4SUoVVkyaCD1CWefEsqA3MyTQg8z74K
	HJYCno9MVTDDCCBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708530293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wUbFq/UapptHuceSM9cs9GaCXgjIWCUQFz0kdXIi4EM=;
	b=1M/w+LocWHVmoByrIQ7QzLhtCc50ZE21bHrfbulpUcHQCwdfbEAJysA7CPKCqLDkOVe0pz
	EFQSATuitvfZmhVvdE2gh31CvVuTzqYbFUPnuFkpkuJ8QqW+RyI2gDnYuuSuLYTtFDcYFK
	WVqKSDNcRD/YcTlL/HN1vPGA5IE2qgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708530293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wUbFq/UapptHuceSM9cs9GaCXgjIWCUQFz0kdXIi4EM=;
	b=Ig4Tccdp4bt0ny2+g4VL4z+rLVx37TQydIbolqA4SUoVVkyaCD1CWefEsqA3MyTQg8z74K
	HJYCno9MVTDDCCBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DCAE13A25;
	Wed, 21 Feb 2024 15:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rg9bHXUa1mWiXAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 21 Feb 2024 15:44:53 +0000
Message-ID: <2667387f-f768-4057-a1d0-abbc2cb40d89@suse.de>
Date: Wed, 21 Feb 2024 16:44:53 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] backlight: Match backlight device against struct
 fb_info.bl_dev
Content-Language: en-US
To: Andy Shevchenko <andy@kernel.org>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
 deller@gmx.de, robin@protonic.nl, javierm@redhat.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20240221094324.27436-1-tzimmermann@suse.de>
 <20240221094324.27436-2-tzimmermann@suse.de>
 <ZdYJ4FhJ9vhzUeiW@smile.fi.intel.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <ZdYJ4FhJ9vhzUeiW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.50)[80.02%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com,lists.freedesktop.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.59

Hi

Am 21.02.24 um 15:34 schrieb Andy Shevchenko:
> On Wed, Feb 21, 2024 at 10:41:28AM +0100, Thomas Zimmermann wrote:
>> Framebuffer drivers for devices with dedicated backlight are supposed
>> to set struct fb_info.bl_dev to the backlight's respective device. Use
>> the value to match backlight and framebuffer in the backlight core code.
> ...
>
>>   	if (!bd->ops)
>>   		goto out;
>> -	if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
>> +	else if (bd->ops->check_fb && !bd->ops->check_fb(bd, info))
> What's the point of adding redundant 'else'?
>
>>   		goto out;
>> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>> +	else if (info->bl_dev && info->bl_dev != bd)
> Ditto.

They group these tests into one single block of code; signaling that 
these tests serve the same purpose.

Best regards
Thomas

>
>> +		goto out;
>> +#endif

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


